Return-Path: <linux-rdma+bounces-522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5310E8221E0
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 20:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357F21C22807
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C915AE2;
	Tue,  2 Jan 2024 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDtzNQg0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01115E95;
	Tue,  2 Jan 2024 19:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355BAC433C8;
	Tue,  2 Jan 2024 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704223025;
	bh=Jk/Wjw6hVbQ2lA3lct5hPUB5efjonhc5P9IQLikWlwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NDtzNQg09PssYylDTe8XVEKIPUHr4S04K6voB3AKVcCLkTtVOFuSZ0dHYCzszil4N
	 Bl++mc91mGzyfs6BZ/s2CX1Y51ymputeTqcFn2slSVgsi35EO6aUFL0ncl6j4y6zza
	 IjivUG/3RX4Ehq8p2hT5MSfHIwzb6p6afPiw/Zajy6GmSIGj/rGYhtH5/eZDyl+t17
	 WqxKGuk+AAaim63PzLn9ap6Sux43/CTGSS9I4yHS19gHmwoUiZMUsxGZtQBfvWLb91
	 7OzCKKgkG5LxBvwMaYXqcyoE2GyjTrFxUg+yYOQHNHPfTCYmYKXP6bRPcjJ9MXBt6g
	 TEPONhMU7oMyA==
Date: Tue, 2 Jan 2024 21:17:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
	dsahern@gmail.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iproute2-rc 1/2] rdma: Fix core dump when pretty is used
Message-ID: <20240102191701.GC5160@unreal>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
 <20231229065241.554726-2-huangjunxian6@hisilicon.com>
 <20231229092129.25a526c4@hermes.local>
 <30d8c237-953a-8794-9baa-e21b31d4d88c@huawei.com>
 <20240102083257.GB6361@unreal>
 <29146463-6d0e-21c5-af42-217cee760b3f@huawei.com>
 <20240102122106.GI6361@unreal>
 <20240102082746.651ff7cf@hermes.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102082746.651ff7cf@hermes.local>

On Tue, Jan 02, 2024 at 08:27:46AM -0800, Stephen Hemminger wrote:
> On Tue, 2 Jan 2024 14:21:06 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Tue, Jan 02, 2024 at 08:06:19PM +0800, Chengchang Tang wrote:
> > > 
> > > 
> > > On 2024/1/2 16:32, Leon Romanovsky wrote:  
> > > > On Tue, Jan 02, 2024 at 03:44:29PM +0800, Chengchang Tang wrote:  
> > > > > 
> > > > > On 2023/12/30 1:21, Stephen Hemminger wrote:  
> > > > > > On Fri, 29 Dec 2023 14:52:40 +0800
> > > > > > Junxian Huang <huangjunxian6@hisilicon.com> wrote:
> > > > > >   
> > > > > > > From: Chengchang Tang <tangchengchang@huawei.com>
> > > > > > > 
> > > > > > > There will be a core dump when pretty is used as the JSON object
> > > > > > > hasn't been opened and closed properly.
> > > > > > > 
> > > > > > > Before:
> > > > > > > $ rdma res show qp -jp -dd
> > > > > > > [ {
> > > > > > >       "ifindex": 1,
> > > > > > >       "ifname": "hns_1",
> > > > > > >       "port": 1,
> > > > > > >       "lqpn": 1,
> > > > > > >       "type": "GSI",
> > > > > > >       "state": "RTS",
> > > > > > >       "sq-psn": 0,
> > > > > > >       "comm": "ib_core"
> > > > > > > },
> > > > > > > "drv_sq_wqe_cnt": 128,
> > > > > > > "drv_sq_max_gs": 2,
> > > > > > > "drv_rq_wqe_cnt": 512,
> > > > > > > "drv_rq_max_gs": 1,
> > > > > > > rdma: json_writer.c:130: jsonw_end: Assertion `self->depth > 0' failed.
> > > > > > > Aborted (core dumped)
> > > > > > > 
> > > > > > > After:
> > > > > > > $ rdma res show qp -jp -dd
> > > > > > > [ {
> > > > > > >           "ifindex": 2,
> > > > > > >           "ifname": "hns_2",
> > > > > > >           "port": 1,
> > > > > > >           "lqpn": 1,
> > > > > > >           "type": "GSI",
> > > > > > >           "state": "RTS",
> > > > > > >           "sq-psn": 0,
> > > > > > >           "comm": "ib_core",{
> > > > > > >               "drv_sq_wqe_cnt": 128,
> > > > > > >               "drv_sq_max_gs": 2,
> > > > > > >               "drv_rq_wqe_cnt": 512,
> > > > > > >               "drv_rq_max_gs": 1,
> > > > > > >               "drv_ext_sge_sge_cnt": 256
> > > > > > >           }
> > > > > > >       } ]
> > > > > > > 
> > > > > > > Fixes: 331152752a97 ("rdma: print driver resource attributes")
> > > > > > > Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> > > > > > > Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>  
> > > > > > This code in rdma seems to be miking json and newline functionality
> > > > > > which creates bug traps.
> > > > > > 
> > > > > > Also the json should have same effective output in pretty and non-pretty mode.
> > > > > > It looks like since pretty mode add extra object layer, the nesting of {} would be
> > > > > > different.
> > > > > > 
> > > > > > The conversion to json_print() was done but it isn't using same conventions
> > > > > > as ip or tc.
> > > > > > 
> > > > > > The correct fix needs to go deeper and hit other things.
> > > > > >   
> > > > > Hi, Stephen,
> > > > > 
> > > > > The root cause of this issue is that close_json_object() is being called in
> > > > > newline_indent(), resulting in a mismatch
> > > > > of {}.
> > > > > 
> > > > > When fixing this problem, I was unsure why a newline() is needed in pretty
> > > > > mode, so I simply kept this logic and
> > > > > solved the issue of open_json_object() and close_json_object() not matching.
> > > > > However, If the output of pretty mode
> > > > > and not-pretty mode should be the same, then this problem can be resolved by
> > > > > deleting this newline_indent().  
> > > > Stephen didn't say that output of pretty and not-pretty should be the
> > > > same, but he said that JSON logic should be the same.
> > > > 
> > > > Thanks  
> > > 
> > > Hi, Leon,
> > > 
> > > Thank you for your reply. But I'm not sure what you mean by JSON logic? I
> > > understand that
> > > pretty and not-pretty JSON should have the same content, but just difference
> > > display effects.
> > > Do you mean that they only need to have the same structure?
> > > 
> > > Or, let's get back to this question. In the JSON format output, the
> > > newline() here seems
> > > unnecessary, because json_print() can solve the line break problems during
> > > printing.
> > > So I think the newline() here can be removed at least when outputting in
> > > JSON format.  
> > 
> > I think that your original patch is correct way to fix the mismatch as
> > it is not related to pretty/non-pretty.
> > 
> > Thanks
> 
> Part of the problem is the meaning of pretty mode is different in rdma
> than all of the other commands. The meaning of the flags should be the
> same across ip, devlink, tc, and rdma; therefore pretty should mean
> nothing unless json is enabled.

I was very inspired by devlink when wrote rdmatool. It is supposed to
behave the same. :)

> 
> I can do some of the rework here, but don't have any rdma hardware
> to test on.

We will test it for you.

Thanks

