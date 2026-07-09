Return-Path: <linux-rdma+bounces-22964-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OoJSIIi/T2oOnwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22964-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 17:34:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7E0732F6C
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 17:34:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=O2zplw0o;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22964-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22964-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4442130D5A08
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9207F383334;
	Thu,  9 Jul 2026 15:28:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA16E382F02
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 15:28:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610886; cv=none; b=ti7PJilCxnWkB2g8nAlXImL5l7HOSxyUHmokC0aZxRdhvhT1JZdfxEXUS5bv4WZuOOjt9itM1BpKWBtbrvrfzG+b509pCU4I62zOfHEqZtKCeH+QNxYPose2BoU3y+lNxVEgAc2rvktql4bSqtE1cJR5xZMBnkgPv4hM9YUjKps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610886; c=relaxed/simple;
	bh=gWk0Tx1PpSkQ7SrrEuYSkz1J6FwF7G6dNVcAD48RLZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sN8U7ym5gS3WqI5gXtEw2mHCNkHY2YtA31REgWVdo5bmWF7K2HV7Mw/EDtr5uSWCRhpFBiMGtqu5uEZ78hVXNQFYjRISIG6Dj48tetA/7Mk5/I2RiEvSx6i3hRmgpjbmP61Wk14p+d1GOSGU05siSCf5eO6loq0reYQjqMv8x4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2zplw0o; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47d70879764so17864f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2026 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783610883; x=1784215683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CHbf130yEa4XzJ/mR051Bre42Fa2Qf6EqrRM78ycRyA=;
        b=O2zplw0opYDrs9XEFRoiSuNPe4G5TK8RLytwyhRA38cvVChmfrlJZY2pXxvI8fMak6
         6tPINHKNR4Gp8RbzuXritr2f7L+hq/gWKOpaDDOFY9DaBlZE13EqgiFPhOODB6w6ZOJx
         3Jgx1boyO6psQzSsJoULhaUO85R9oo0Z4vV7UUo5FHbYExmbbf73KnbEp3SUUFH+YPWi
         v3BVKiRiYcxJPLe5ia4sp9vC788x8wq62cepvyeAXvulCpcr8G2czVPgYxcCbqrzIwCu
         6hXKYAMEMdpGeX+gdTG2HqshtrpnEb7MpXCon+blToWhbkX56zGRCu+WKuAqGLRpD1HR
         GSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610883; x=1784215683;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHbf130yEa4XzJ/mR051Bre42Fa2Qf6EqrRM78ycRyA=;
        b=jd6agm5iiNsFcL++nS5PdQOKDnIdFEhltMkV0RvUbUyH32iE7VY1cRJsyYTN1wqgLM
         Kx46eb73m1dMiObl7A1Hs3+75DBxnhTanu63Kzc16/+n4Ghx0FOHAgji21UJv80zHLV1
         tX3FnIv1WyYA6CYP21kBVxjgu9u5Xjprz1o2vFvKEK0sSUfxbhukuCxY0iN59wWq/ig+
         HaLWZfOgTupfCy5Hp+4U9QbHtyU5Fw5NX9iht5gHY4nu/iVPECfiE1B70giyBe1JClTh
         Ogg/TUZTM7wCDHRDBGpAhfMnRYQfWCXkYwDLo5S2OFItKpR2cTuuT00K2w6jPt5jh7Dg
         wBkw==
X-Forwarded-Encrypted: i=1; AHgh+RoCS00XwG2l9+jFWvLufb5X1prapaRJSvyi6KkJyN81NgDcKWx0MgkrP3TDyPOLx9ClHu6NYywIcdM9@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5YXxYIKMBwcW4Q8cTZBIqzZAsRAIsh8gSVaL6+io8/WsdNaY
	5ojQx707ZDhwVniRx1avFYkrWCJdKUrUldEv6QJEyrfkAlfQ4CWGtId9
X-Gm-Gg: AfdE7clbG7fjMYgXWAcKJptrR3u3gZsmJX4sgJ8jxj+wFu6urmSUvIelJz207gOQxVW
	Lv7NR5+J4wLnC2F836vBhvRIH0Dock2rFeLeb+DcdaepyE757ZwoMUqDa8jOjXCzPwChSuqpR0p
	WxJ2x5kilLKO7uHI8Xr3Jg6kORvEoWHUzd0JrwLc9C0Tdh2cUBQ9v6yMb2wl1BD1EeyviaNlJGi
	CsKdq+axtOUhGZ+25nO57zMlUi3Y4sbXmCwlFhlUlN+x+TJQJPijGkK6u2Rbio4e4e4GZIy9bLB
	84sB1tJu77FmO9fhQMIAPMZnNG386BsxpT6KTTdeGAIr9iv5Q6SeSDn3cnWZCO+UsgHxfypOCFG
	Kt0O564EKrtZ1E+BZ1RhiKWJxz174mkhTtl/Ckd2sD95c7ReKt/KbU+/myHqebD+gWLL30K/Hxx
	9lWk4WafuwzaWJxhZjlQ/WwzqC2TJbpTkHUDO7fkdJkfSExg==
X-Received: by 2002:a05:6000:18a3:b0:47d:ef25:ff3b with SMTP id ffacd0b85a97d-47df0812ef6mr8098275f8f.49.1783610882799;
        Thu, 09 Jul 2026 08:28:02 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm49942587f8f.23.2026.07.09.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:28:02 -0700 (PDT)
Date: Thu, 9 Jul 2026 16:27:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
Cc: "xuhaoyue1@hisilicon.com" <xuhaoyue1@hisilicon.com>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, Oleg Kazakov
 <Oleg.Kazakov@kaspersky.com>, Pavel Zhigulin
 <Pavel.Zhigulin@kaspersky.com>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Wenpeng Liang <liangwenpeng@huawei.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Xi Wang
 <wangxi11@huawei.com>, Weihang Li <liweihang@huawei.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/hns: Fix arithmetic overflow in
 hns_roce_v2_set_hem()
Message-ID: <20260709162759.1d836699@pumpkin>
In-Reply-To: <24c0a3cf43074b37bb1c9c321a73f470@kaspersky.com>
References: <20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com>
	<20260708092146.3325855-1-Alexander.Chesnokov@kaspersky.com>
	<20260708181941.1ad1e112@pumpkin>
	<24c0a3cf43074b37bb1c9c321a73f470@kaspersky.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Alexander.Chesnokov@kaspersky.com,m:xuhaoyue1@hisilicon.com,m:lvc-project@linuxtesting.org,m:Oleg.Kazakov@kaspersky.com,m:Pavel.Zhigulin@kaspersky.com,m:stable@vger.kernel.org,m:liangwenpeng@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:wangxi11@huawei.com,m:liweihang@huawei.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-22964-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC7E0732F6C

On Thu, 9 Jul 2026 04:56:56 +0000
Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com> wrote:

> > When does the value overflow.
> > Yes, the expression can overflow and the result is assigned to a
> > 64bit variable, but I'd have testing this code would have showed
> > the problem. So what is the customer visible impact?  
> 
> You're right, there is no reachable overflow. In hns_roce_calc_hem_mhop()
> the 32-bit table_idx is split into base-chunk_ba_num digits i, j, k, and
> here they are recombined: i * chunk_ba_num + j equals table_idx /
> chunk_ba_num, and the full expression equals table_idx, which is u32.
> i is additionally bounded by ba_l0_num. So the arithmetic cannot exceed
> U32_MAX on any real input - there is no customer-visible impact, and the
> SVACE report is a false positive.
> 
> I'll drop the Fixes: and Cc: stable tags and resend as a standalone
> hardening/readability change. If you'd prefer to just drop it, that's
> fine too.

Best just dropped.

	David

> 
> -----Original Message-----
> From: David Laight <david.laight.linux@gmail.com> 
> Sent: Wednesday, July 8, 2026 8:20 PM
> To: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> Cc: xuhaoyue1@hisilicon.com; lvc-project@linuxtesting.org; Oleg Kazakov <Oleg.Kazakov@kaspersky.com>; Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>; stable@vger.kernel.org; Wenpeng Liang <liangwenpeng@huawei.com>; Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>; Xi Wang <wangxi11@huawei.com>; Weihang Li <liweihang@huawei.com>; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] RDMA/hns: Fix arithmetic overflow in hns_roce_v2_set_hem()
> 
> Caution: This is an external email.
> 
> 
> 
> On Wed, 8 Jul 2026 12:21:46 +0300
> <Alexander.Chesnokov@kaspersky.com> wrote:
> 
> > From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> >
> > If hop_num is 2 or 1, then the expressions like i * chunk_ba_num + j 
> > are computed in 32-bit arithmetic before being assigned to a u64 index 
> > field, which can lead to overflow.  
> 
> When does the value overflow.
> Yes, the expression can overflow and the result is assigned to a 64bit variable, but I'd have testing this code would have showed the problem.
> 
> So what is the customer visible impact?
> 
>         David
> 
> >
> > Declare i, j and k as u64 so that the address index arithmetic is 
> > performed in 64-bit.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: a81fba28136d ("RDMA/hns: Configure BT BA and BT attribute for 
> > the contexts in hip08")
> > Cc: stable@vger.kernel.org
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> >
> > ---
> > Changes in v2:
> > - Instead of casting the operands to u64, declare i, j and k as u64
> >   so the index arithmetic is performed in 64-bit (David Laight).
> >
> > v1: 
> > https://lore.kernel.org/linux-rdma/20260707140938.3106919-1-Alexander.
> > Chesnokov@kaspersky.com/
> > ---
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c 
> > b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > index 1c180a6b1c07..3469a9a68d3b 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > @@ -4238,7 +4238,7 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
> >       struct hns_roce_hem_mhop mhop;
> >       struct hns_roce_hem *hem;
> >       unsigned long mhop_obj = obj;
> > -     int i, j, k;
> > +     u64 i, j, k;
> >       int ret = 0;
> >       u64 hem_idx = 0;
> >       u64 l1_idx = 0;  
> 


