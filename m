Return-Path: <linux-rdma+bounces-6906-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE66CA05FBA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45BB7A02EF
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCA91FDE14;
	Wed,  8 Jan 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FShq/pr7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9D15E5B8;
	Wed,  8 Jan 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349261; cv=none; b=U0BIYCHHqSYHJSq1FDY9w2hnXAIVL6x81EIgxFBZaHc2c6pwtrbfxYTkXGm3wc4vXKDocjvxXZpt0ymPTxYaj9eazZGlTX+CZSpYcbNW5BZ6xToceIJSLMIWaQnZKhhTU7E1HGGqxFTwcVFyOXejnlDanuUEdIDMrMIxjz6Q5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349261; c=relaxed/simple;
	bh=RUC9wKUn5ixD8RsFBPli3PsKQfKmZpRo30epaksmkIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoSHNdm1QaItejI0GKHxQZkELqOI2QH1RJBe+8/bT3moAZaLIeUX1/OBFe6TALaN+AtaENN1hTabqfYelwgvIZQWuvqCzR+NVpTu7DuCx0kyqqkrklshHeq32HKLDzptqX42wgW7vBlWybYhcTLPPWs4vinL0pbh1mCACHRjyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FShq/pr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39059C4CED3;
	Wed,  8 Jan 2025 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736349259;
	bh=RUC9wKUn5ixD8RsFBPli3PsKQfKmZpRo30epaksmkIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FShq/pr7eRD5iiXHdl7e4CTwMZ/5HCNF0GxC92j4iRQQYj159eli39fjaRe6uOrfn
	 LnCcjKVTaoV8JMZjtuNv62WXkeJmAzfP0jS73tKOqcsn/aY8i0v/RKzuUcC6hwGOwL
	 gfe3ZeHG/f6ffONF4/GC7p7iMrtt4szijJ0R+THkcbnyLXaeeOYo8wmonmxrWnjUNE
	 CRN7I0vVdSfZNSTVdT7pBex4LeiTcKls7Xqz4Hyc6HGSwae3lXAiZnn1fEcp+veCi3
	 pTNdb/6b34hHKaYjnkFgt8vXBsZ0ZCs7vBkglAzAu5oDytgkuSxyXmJEryAJjxwsVI
	 PEc9PFK6RyKAQ==
Date: Wed, 8 Jan 2025 17:14:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>, Potnuri Bharat Teja <bharat@chelsio.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Michal Kalderon <mkalderon@marvell.com>
Cc: jgg@ziepe.ca, cmeiohas@nvidia.com, michaelgur@nvidia.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] RDMA/iwpm: reentrant iwpm hello message
Message-ID: <20250108151415.GG87447@unreal>
References: <661ee85f.a4a2.193e4b2f91b.Coremail.linma@zju.edu.cn>
 <20241224092938.GC171473@unreal>
 <103c061b.e87e.193f84b0840.Coremail.linma@zju.edu.cn>
 <20241224141127.GH171473@unreal>
 <48307bf.eecb.193f974dadf.Coremail.linma@zju.edu.cn>
 <20241224192616.GI171473@unreal>
 <24cc4fc5.f216.193fb898b6c.Coremail.linma@zju.edu.cn>
 <20241230182828.GA81460@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230182828.GA81460@unreal>

On Mon, Dec 30, 2024 at 08:28:28PM +0200, Leon Romanovsky wrote:
> On Wed, Dec 25, 2024 at 09:58:35AM +0800, Lin Ma wrote:
> > 
> > > 
> > > Do you have reproducer for that?
> > > 
> > 
> > Yep, I attached the PoC code, please enable CONFIG_INFINIBAND
> > for testing.
> 
> Thanks a lot for the repro. I wonder why iWARP folks never complained
> about it, Anyway I have local fix, but need to test it before sending,
> will do after New Year holidays.

I was wrong, there is no simple fix for this issue.
The root cause for these lockdep warnings is nested locking in iWARP.
IWCM uses dump callbacks as doit ones. See the following FIXME line:

  184         /* FIXME: Convert IWCM to properly handle doit callbacks */
  185         if ((nlh->nlmsg_flags & NLM_F_DUMP) || index == RDMA_NL_IWCM) {
  186                 struct netlink_dump_control c = {
  187                         .dump = cb_table[op].dump,
  188                 };
  189                 if (c.dump)
  190                         err = netlink_dump_start(skb->sk, skb, nlh, &c);

In our case,
 cb_table[op].dump ->
 	iwpm_hello_cb ->
		iwpm_send_hello ->
			rdma_nl_unicast() <---- this shouldn't be in dump callbacks.

The right and only viable solution is to convert all IWCM to use .doit callbacks.
Do any iWARP developer/user volunteer for such conversion?

Thanks

> 
> Thanks again.
> 
> > 
> > Thanks
> > By the way, Merry Christmas~
> > 
> 
> > // gcc poc.c -static -o poc.elf -lmnl
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <stdint.h>
> > #include <string.h>
> > #include <stdbool.h>
> > 
> > #include <libmnl/libmnl.h>
> > 
> > #define PAGE_SIZE 0x1000
> > #define RDMA_NL_GET_CLIENT(type) ((type & (((1 << 6) - 1) << 10)) >> 10)
> > #define RDMA_NL_GET_OP(type) (type & ((1 << 10) - 1))
> > #define RDMA_NL_GET_TYPE(client, op) ((client << 10) + op)
> > #define RDMA_NL_IWCM (2)
> > #define IWPM_NLA_HELLO_ABI_VERSION (1)
> > 
> > enum
> > {
> >     RDMA_NL_IWPM_REG_PID = 0,
> >     RDMA_NL_IWPM_ADD_MAPPING,
> >     RDMA_NL_IWPM_QUERY_MAPPING,
> >     RDMA_NL_IWPM_REMOVE_MAPPING,
> >     RDMA_NL_IWPM_REMOTE_INFO,
> >     RDMA_NL_IWPM_HANDLE_ERR,
> >     RDMA_NL_IWPM_MAPINFO,
> >     RDMA_NL_IWPM_MAPINFO_NUM,
> >     RDMA_NL_IWPM_HELLO,
> >     RDMA_NL_IWPM_NUM_OPS
> > };
> > 
> > int main(int argc, char const *argv[])
> > {
> >     struct mnl_socket *sock;
> >     struct nlmsghdr *nlh;
> >     char buf[PAGE_SIZE];
> >     int err;
> > 
> >     sock = mnl_socket_open(NETLINK_RDMA);
> >     if (sock == NULL)
> >     {
> >         perror("mnl_socket_open");
> >         exit(-1);
> >     }
> > 
> >     nlh = mnl_nlmsg_put_header(buf);
> >     nlh->nlmsg_type = RDMA_NL_GET_TYPE(RDMA_NL_IWCM, RDMA_NL_IWPM_HELLO);
> >     nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
> >     nlh->nlmsg_seq = 1;
> >     nlh->nlmsg_pid = 0;
> > 
> >     // static const struct nla_policy hello_policy[IWPM_NLA_HELLO_MAX] = {
> >     //     [IWPM_NLA_HELLO_ABI_VERSION]     = { .type = NLA_U16 }
> >     // };
> >     mnl_attr_put_u16(nlh, IWPM_NLA_HELLO_ABI_VERSION, 3);
> > 
> >     err = mnl_socket_sendto(sock, buf, nlh->nlmsg_len);
> >     if (err < 0)
> >     {
> >         perror("mnl_socket_sendto");
> >         exit(-1);
> >     }
> >     return 0;
> > }
> 
> 

