Return-Path: <linux-rdma+bounces-514-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B035821865
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 09:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB831F21F56
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35BD46BA;
	Tue,  2 Jan 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPWCVDEL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD16AA1;
	Tue,  2 Jan 2024 08:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39629C433C7;
	Tue,  2 Jan 2024 08:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704184382;
	bh=R8U/2kZF2yuyBg7/eL/B7CU9p17fLKIzW3PZsS7W7Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPWCVDELXMtNoW7754bzg5gToUshkGkxexsRrYP0YX9WgxKu+NQ1zl5jKfzY0vrIM
	 dubt3gbb4v7rUGnlUWgEUQUOvClDbe2LS+Q9DMoLxSD2sKejsrrLukoiPK0BZprKei
	 l8XUSO+B6nMN+TErGMcHx1mpN9sl3NKmEz8Ld2IcinRSX9jpHFf7uF7Us9b55nOTBp
	 cEmx13hS3lzVCVUaCzZfKIZNleAB7XQqHaNfMTczEuioskVK1YJwi5g8Vlc1pl2RC0
	 dA0SNAR4JQf1UJq7i3gaGqMBfRaABCrlgVzCgBhTO1pQ+DlTfqtYI0JRDbj7wra+Ws
	 847JlSLqw7iow==
Date: Tue, 2 Jan 2024 10:32:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chengchang Tang <tangchengchang@huawei.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
	dsahern@gmail.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iproute2-rc 1/2] rdma: Fix core dump when pretty is used
Message-ID: <20240102083257.GB6361@unreal>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
 <20231229065241.554726-2-huangjunxian6@hisilicon.com>
 <20231229092129.25a526c4@hermes.local>
 <30d8c237-953a-8794-9baa-e21b31d4d88c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30d8c237-953a-8794-9baa-e21b31d4d88c@huawei.com>

On Tue, Jan 02, 2024 at 03:44:29PM +0800, Chengchang Tang wrote:
> 
> 
> On 2023/12/30 1:21, Stephen Hemminger wrote:
> > On Fri, 29 Dec 2023 14:52:40 +0800
> > Junxian Huang <huangjunxian6@hisilicon.com> wrote:
> > 
> > > From: Chengchang Tang <tangchengchang@huawei.com>
> > > 
> > > There will be a core dump when pretty is used as the JSON object
> > > hasn't been opened and closed properly.
> > > 
> > > Before:
> > > $ rdma res show qp -jp -dd
> > > [ {
> > >      "ifindex": 1,
> > >      "ifname": "hns_1",
> > >      "port": 1,
> > >      "lqpn": 1,
> > >      "type": "GSI",
> > >      "state": "RTS",
> > >      "sq-psn": 0,
> > >      "comm": "ib_core"
> > > },
> > > "drv_sq_wqe_cnt": 128,
> > > "drv_sq_max_gs": 2,
> > > "drv_rq_wqe_cnt": 512,
> > > "drv_rq_max_gs": 1,
> > > rdma: json_writer.c:130: jsonw_end: Assertion `self->depth > 0' failed.
> > > Aborted (core dumped)
> > > 
> > > After:
> > > $ rdma res show qp -jp -dd
> > > [ {
> > >          "ifindex": 2,
> > >          "ifname": "hns_2",
> > >          "port": 1,
> > >          "lqpn": 1,
> > >          "type": "GSI",
> > >          "state": "RTS",
> > >          "sq-psn": 0,
> > >          "comm": "ib_core",{
> > >              "drv_sq_wqe_cnt": 128,
> > >              "drv_sq_max_gs": 2,
> > >              "drv_rq_wqe_cnt": 512,
> > >              "drv_rq_max_gs": 1,
> > >              "drv_ext_sge_sge_cnt": 256
> > >          }
> > >      } ]
> > > 
> > > Fixes: 331152752a97 ("rdma: print driver resource attributes")
> > > Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> > > Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> > This code in rdma seems to be miking json and newline functionality
> > which creates bug traps.
> > 
> > Also the json should have same effective output in pretty and non-pretty mode.
> > It looks like since pretty mode add extra object layer, the nesting of {} would be
> > different.
> > 
> > The conversion to json_print() was done but it isn't using same conventions
> > as ip or tc.
> > 
> > The correct fix needs to go deeper and hit other things.
> > 
> 
> Hi, Stephen,
> 
> The root cause of this issue is that close_json_object() is being called in
> newline_indent(), resulting in a mismatch
> of {}.
> 
> When fixing this problem, I was unsure why a newline() is needed in pretty
> mode, so I simply kept this logic and
> solved the issue of open_json_object() and close_json_object() not matching.
> However, If the output of pretty mode
> and not-pretty mode should be the same, then this problem can be resolved by
> deleting this newline_indent().

Stephen didn't say that output of pretty and not-pretty should be the
same, but he said that JSON logic should be the same.

Thanks

> 
> I believe the original developer may not have realized that
> close_json_object() is being called in newline(), which leads
> to this problem. To improve the code's readability, I would try to strip out
> close_json_obejct() from newline().
> 
> Thanks,
> Chengchang Tang
> 

