Return-Path: <linux-rdma+bounces-19645-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCJJMwF18GkMTwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19645-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 10:51:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3E480995
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 10:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C7F0301E983
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A22318146;
	Tue, 28 Apr 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="GoNk92cy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4A3D47A8
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366223; cv=none; b=Ntm+DiOfpYIEk9FoitNXeTh2Qc0Qvh6f6aK2XfYQalcl9hPR/MlSNQ+QYUlcIXnURS2H6xH2jLkxKTed0nXfWOlieSz8TltbFqCED5sXvQythK22jHi5stk3y4EsCs4cufbWvGrEDVyhyEgGjSjXKHpUgUMiBBimxL34FqJsFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366223; c=relaxed/simple;
	bh=Gmcx42UCclfedT7zvfaYZ+vCKlD+KawZOe4bUpTtR5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbsP/VoPaVDYi/AbYwLCywsFs1dSlwcFsINlaDmjCJzlVkYg4IEfmYTVOxV0ImtjEbj9xLnW4LfoV8bjv1ShwkYxZ/0j55tmUpXiWeP7er0D4DzzR+2ggXs25XZ04sFDos2YB6ygnEFwRSmBBIBbJWE6h0gW/r+IN8JF4N0OXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=GoNk92cy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43fe608cb92so7532577f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777366217; x=1777971017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+u4ROMiDJmGKEB0IeNa1RiDmxb4eTAwbvzBvVVCkGa0=;
        b=GoNk92cyhOZdLnjLDRJWqCPvuYFjq8Xw5zN64E3rlP7roG1RCnLXcj+yuhd9PNi0LA
         Ckjhw1GfUTX8QdqCbt+1Lhgn17oq7CuzjjBG375afzttXhdfzteWMPCbqNLhmRp4NO8h
         4apRd54tkfpfJNWDC7p4/zYUModwfkit3imYzgF80DgSa+r3jy1UTedutaF6DDQR8PnR
         eh/4hroqk+IwGE6PVE/Hfp+VmHs9O6OmL1p1X1KFPsdqUEjinVPPltrqhNbiFM1zwNn2
         Lrjsp5vs/37kVclDNET/X5Zgt+8MEu2d01X0oSud/2JihaRaNt8vQ/Ps3PCnOEyiMv75
         EoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366217; x=1777971017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u4ROMiDJmGKEB0IeNa1RiDmxb4eTAwbvzBvVVCkGa0=;
        b=j+Y9+WVmQv4Yyb61U4r13X8T9UzSGbKVjNf8H3yov1BlvdxStuiEEg5palpmUDPxuR
         piMeXePS9SYwz4jdyqENK9UJCgwI99zXGoi/FDB5NZULeoEPNixolr0Huo/O8mXYhLOv
         uRDLruQhaRKBh5yJJ4KqxwlqSHCx/lHo+JIGQ71ass7uZJWobmDtgS3Uvn44AZex8XMl
         7CL25lrljVoexrenlmuoiMyXKiW05j0//XVokTvgCRXOOCSXzRphivRzZtAyFI104FHw
         DzIF3nVVo4IVhg3arArlTT2sSg4NV/TbuQaTs0Lc2xQMBBpYjokdy+3EgCr7wsvvUgx7
         E7tw==
X-Forwarded-Encrypted: i=1; AFNElJ+rxF0OZ37uXuxDaKQ05u0OYarENt4sm6/lGvCwU9wEbWniNS61VJpSg1OiS/KYy5WwpjLaTf45XMOQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyqgcmJ9ns+pnvfD9cm3qp5qEsmUYCRpWqN6bgS8XlxhwB063JV
	/UygKhywuxEJzfUymNI9sUycoJ/uYVeL5DXNXsHl8Cq5GCp9s7CJ4/vzxkaCLNleNPQ=
X-Gm-Gg: AeBDievDjszbyyUoaDVl+roG7+PV7mpo4gaVUgGyHFe3rjPw6KAeJZd2s4ut1/YKceo
	N3DMr2TVsuQpKDU8PsGPhk97EN2TfMPzrLATREmf3snAEUabiAtCNsp4/n0TVPPohBcvCVoTGvl
	qSdv6UHCjLe0WxL0/FZS2yn0l/63BG+f81ijU8t9NN7qsyWmz6+I+Bbq8Y/n0OvNGyVH9KnezCG
	5K61iSh5fnVFT0eHtW5qwdCNJYaOUqFO/BCctb6ZNS5+lUa7PYtADcBjB6Xt5TtILGWm9FsySW2
	3To/LMr5TYmOAUNEYcw1l7/WTUDqUQUUuDI9PWaSAkGznIZU/nXNgDhszLmJb0BtOP9UVYlsBF4
	avQrJSVNZCyJD0XDHexGKfU584jdTEPEtpLAPgynxc4e0x7r8co9LA94i6IEJnz/sJ+ohXwf3Of
	scKL8yACBjBe2K8bD3ieTQGa9lJnhlXW4F1vcHfk8IlOz8EUMJZo94
X-Received: by 2002:a05:6000:2885:b0:43f:e659:1705 with SMTP id ffacd0b85a97d-44647fbe79emr3965116f8f.20.1777366216839;
        Tue, 28 Apr 2026 01:50:16 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f6a1sm4731276f8f.13.2026.04.28.01.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:50:16 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:50:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, 
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <afB0aaEsa7DALeIv@FV6GYCPJ69>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260421134635.GG3611611@ziepe.ca>
 <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
 <sdmwjrxzgbg4iz5cspcdkvvdb7rjgdggkw4njct3pkdsvhsq24@qstis6jnplap>
 <20260422165101.GO3611611@ziepe.ca>
 <20260426135340.GH440345@unreal>
 <20260426225034.GA3540346@ziepe.ca>
 <jpobfdsuuj4wmrqkxzpjmfjxgz6vn2m6a6wy666yfapv6hzytj@6g5qrelixuwe>
 <20260427185445.GL440345@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427185445.GL440345@unreal>
X-Rspamd-Queue-Id: 1DB3E480995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19645-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Mon, Apr 27, 2026 at 08:54:45PM +0200, leon@kernel.org wrote:
>On Mon, Apr 27, 2026 at 12:48:46PM +0200, Jiri Pirko wrote:
>> Mon, Apr 27, 2026 at 12:50:34AM +0200, jgg@ziepe.ca wrote:
>> >On Sun, Apr 26, 2026 at 04:53:40PM +0300, Leon Romanovsky wrote:
>> >> > Well, brainstorming idea. I'd like to hear from Leon too
>> >> > 
>> >> > But if we set the general goals as:
>> >> > 
>> >> > 1) All umem creations should have a struct ib_uverbs_buffer_desc at
>> >> >    the UAPI boundary
>> >> > 2) ib_uverbs_buffer_desc should pass directly to umem code without any
>> >> >    driver touching it. ib_uverbs_buffer_desc should be the only way to
>> >> >    create a umem from a driver.
>> >> > 3) Existing UWH umem descriptions must continue to work if the desc is
>> >> >    not provided, by reforming them into a desc
>> >> > 3) Cleanup and lifecycle should be centralized
>> >> 
>> >> I have mixed feelings about this. My CQ conversion showed that even a simple
>> >> task like creating a CQ umem (numb_of_entries * size_of_entries) ends up full
>> >> of creative hacks in various drivers. Because of that, I see real value in
>> >> pushing as much logic as possible into the core code instead of duplicating it
>> >> across drivers. However, my later attempt to change the QP path made it clear
>> >> that creating umems in the core is not a viable goal in the general case.
>> >> 
>> >> Another outcome of that work was realizing that CQ resize (and probably MR
>> >> rereg as well) becomes messy when we keep the "old" umem around. Splitting
>> >> creation and cleanup into different layers probably will going to hurt us
>> >> at some point of time.
>> >> 
>> >> To summarize:
>> >> 1. The most practical fix is likely to provide a driver callback to create
>> >>    the umem when needed, as you suggested.
>> >> 2. We should reduce the use of UWH as much as possible in favor of a
>> >>    well-defined schema. In the long run, we want to add more umem types,
>> >>    and many drivers should work out of the box under that model.
>> >> 3. Explicit behavior is preferable. If a driver creates something, the
>> >>    driver should also clean it up.
>> >> 
>> >> I'm not saying no to your proposal, just expressing my thoughts.
>> >
>> >So, I think making small steps that upgrade all drivers will be
>> >helpful here.
>> >
>> >If we can get all drivers calling the same attrs function and giving
>> >their uhw parameters that is a good step closer to being able to put
>> >that in a function if that is how things need to go down the road.
>> >
>> >And it does #2..
>> >
>> >Not sure about #3, we already moved toward core destroying umems it
>> >may not be a good idea to try to undo that now.. But maybe we just
>> >keep that for CQ and leave QP as driver managed?
>> 
>> I think that the uniform approach is better in order not to confuse
>> people. Perhaps one day we will manage to untangle the create QP flow
>> and separate user/kernel paths too. But:
>> 
>> After lots for thinking and back and forth motions, I tend to agree
>> with Leon, the init/fini alloc/free should be symmetric
>> in drivers. Now, that the core will never create umem and the driver is
>> always responsible to create it, the driver should be the one to
>> do release. Drivers still store the umem pointer locally.
>> Then there is not need for ib_umem_list, makes things much easier
>> and more neat. Another pro is, the code does not care if called on
>> user or kernel part.
>
>I will try to make this a bit more complicated. One of the reasons the
>core code releases the umem is that umem has a special meaning: it is
>memory pinned with DMA mapped to it  and exposed to user space,
>and both HW and SW may read from or write to it. A driver that forgets
>to release a umem can potentially cause serious problems to whole system.
>
>So core at least needs to be aware of all exposed umems and be ready to
>cleanup them if driver is removed.

Hmm, I think this safety-accounting is possible. The list would be not
per-object but per-dev. Will try to draft it.


>
>I afraid that we will never find "correct" design here. We just need to
>decide which approach has less drawbacks.

Correct.


>
>Thanks
>
>> 
>> 

