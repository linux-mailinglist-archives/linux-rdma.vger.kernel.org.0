Return-Path: <linux-rdma+bounces-18312-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MtWCBeZumndZQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18312-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 13:22:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB8A2BB61D
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 13:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66FB630DB1E4
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCA238B7D7;
	Wed, 18 Mar 2026 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IfyZOjKW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260B3E47B
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836415; cv=pass; b=V3+7aAu8MoF4XllXToKvnG/BkNomJmZMkMIg8D7PF3/N51BACKFaWrZQ1C+j+gbLfxeUnaYNR/pMc4yDFzUb6C7sWI5YXGzlAgFfx2WpGRJHv7kNzDZjuYLG9NEbvDYrihN0r+EgcHKSPNGpednW9trLCw8aNfzgAvHzC7EBlXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836415; c=relaxed/simple;
	bh=vvVhL/+wxuWqucAa77So5ZAeSkHYd5oXErxNuewvWWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYbgCfnkJO3oGxiYOms8mN40FY5IUYENZCaKMNnxMUrMg8YF/9AREuOHBUagZ57RrKeI3G/c4yE12h+bZVpk1/aYC2XShgXxx+Erlc3634mFiPUWflDiqXffwOPzxfzJAbZHMfgQKMI/FbJhtcQz86Libhxp9qEpra+VsPyJYwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IfyZOjKW; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a1307438ddso6758328e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 05:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773836412; cv=none;
        d=google.com; s=arc-20240605;
        b=QnpjcDr5nCvahpyfkEOxhOv0uKesFOiKqT93AuMrwQsehGp+XRCccVij+01LXF37cs
         iZuwR8gDQpUYhLDz5VB/9u/jX2PDmA/H/akhWQAtEQgFYNI5zKzv0lunpd+OkVicLjEW
         g9bW7fLkdlPfkd45u4QdRt8+lhYGVErn/zetFKZTX0+eUG1MIu20qFZOW+zNQRYVLw5E
         SScWSI9mU2UKqgFRml98SgOahNMGad/r8Qq5QIo3plP/xGeP+bKTTCRRuKNctUvEojX3
         Qm8puptrCxmU/P+lYpOoeLftQ4tMw3JQWCmT+1Gj8UTdBIyTuO1PRNLvwNy+lZ8aJ8gY
         LtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aCsiVQYuuJsEXiT9TRjyOhELisP1aeklLB/cB8yzdNc=;
        fh=I9BuGvu0q3WN+ChO9tETd/fUQSijQDjNDolDqVgetq8=;
        b=Juo3sfrWXAr35N0NmlTTBcD9PScqXI8QIC0r3SCiFRtxdtICu1QJVt3BbrPueD68vR
         CrIdfqCUOCmYEHHK7TTppOJ4EPzUnLhAc/W44RwvCl4Sf9mMdhS2vsekbsVlEjceCeMZ
         iifBmsGzWinoWCFMkFxWC+bwloDTLGRfKoetSK9aEngIUAZUiQx3X/Ri98SYrtgfph9F
         7aPcCCUJnrBBLpWr/T0GbNp05S7MsvyW3g39t3bB/lU5whq7X9c2l2V+5TWJqTSI6K2/
         6Me0heDiUD4atntDCviTOAp/ui3LXxvmJW6tJqIM+xd7JGp070EkXUeup0LY6E27ve2g
         UWlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773836412; x=1774441212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCsiVQYuuJsEXiT9TRjyOhELisP1aeklLB/cB8yzdNc=;
        b=IfyZOjKWNMacJV7O361hGbUZh2JNEr1AnL8V93YsoKdOQaOFUr9rQueV5c3E8g4QSR
         edFJHRk24nnL6oq8sFPe4CZ0SmtsBfv1Mn/FheuXzKptfuJbYXBgq3+6aHDhswftawId
         kJNTv+oIDkOBu6l0QMUyGYbqFJiLlVeOFN3TbgaEggCsvTtmJRKzpmlJFLmhhPeV5UWw
         xavBBMnQ6fcZzZVho0WUeTsoEWJ/c+w2YZWSwmDYtkXCtAuQKrtpdwoR2XEZcIIqaDjc
         whQsrcqAPW4X1rkZ4R2ZDEe0h7PJGr15xEX23jGEPabjulbt5a/Ulu1pqmkWgXTJVfjC
         EOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773836412; x=1774441212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aCsiVQYuuJsEXiT9TRjyOhELisP1aeklLB/cB8yzdNc=;
        b=kzRzwgYgZQZyx3tnPGBa6c4ok+myVIv6txT7OxBIQ6yBOxHpTH1P4t9Tnj4Mev963T
         Ix3aTF/NXvCTq/ncM1QhFGAPfOI6GKWE3iaGb+nKVchKMewHLfsB7xfGfwRq7awT0hQI
         e92xyDYtZQwykceFBt5txYk6e4GGJfXbjwdtDwmK2eUHxtwBlopOsI4ONx6juyXPDhmT
         w1GwoCiRr7tYep8mAw2zmlzS32afNvLlRrnhnC5jwH7nStdEqlMF68R3pTq3NZW4DLvU
         2exRv6INNQho2AbeC1aumcnm2V9AXDeRsS2Gk9GgwpqV1spW4cju0QRJ+3OeEqp4swWB
         rwYA==
X-Forwarded-Encrypted: i=1; AJvYcCXovLuWXJVFCOZFzcK8yZ0lxgRjGtbQ24QdpMUir4KhkgT2DoWUSihS7NgeNAKKOe74RCyZbX0CUqeS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rGk4C/yGNqjO/04rA7mX24f6cneESIAsTRFH7YplR4+5sC94
	KjSzikstIZITYe5IODdlj4P3hVOqC2K/2tZNvEL3++KKMLssudEJ1NZdCMhNZCdPB7jImA2mVm0
	YmxGzhmFmTPlpOofKbjE6XwhNoF/CRJVrkozsB3DUHpCJKGui8jxu2pM=
X-Gm-Gg: ATEYQzwai48mHN0GB+vbjiAjdL7nyj7sgXcGVUHKjpS1/NkxzjbuEkz/Wsl3DqIOA4n
	Zwv0ftcy5q9DxJd1a7GSypivelkRfXfDEf+cnfWSbtrVsWp9/8ihBbxx2q2THuZqtXGv+qYpknH
	MOZkVW4PxHk2wMTif3ghY6Kadlc+1bN1jKUdMe3nXqPlRhqqkdx71kxaxz3mUPl/TKdMNeYZ3go
	W1rDECHBhGOeCqsl49jYE8RrBpSEPT36bIGpJ56okSRWFgLVBK36NU9XRHlprxzY+lRVfrfwTOZ
	IdKxqhRWQ9M55i+qi9r8eekKTSx9ni+XY2pVxZVs
X-Received: by 2002:a05:6512:4017:b0:5a1:4473:bb44 with SMTP id
 2adb3069b0e04-5a2796b946emr1207015e87.33.1773836412120; Wed, 18 Mar 2026
 05:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313154023.298325-1-marco.crivellari@suse.com>
 <20260316201301.GL61385@unreal> <CAAofZF61VPo8VAX8zXUZnY-ydDYAR0N0mN2egaeTzXbiaKQbDw@mail.gmail.com>
 <20260317162429.GA61385@unreal>
In-Reply-To: <20260317162429.GA61385@unreal>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 18 Mar 2026 13:20:01 +0100
X-Gm-Features: AaiRm51UitvQ_l6oXBnLvI7rwVIxGe9L70kqCxgFIpHSmrPpblcraz8exSvis04
Message-ID: <CAAofZF4jW2hD+UsBG8w3zYPeGGaHeSx0tSY2Prd2dXLLBkaf1g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Replace use of system_unbound_wq with system_dfl_wq
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18312-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7AB8A2BB61D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 5:24=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
> [...]
>
> Actually, RXE already have one workqueue in rxe_alloc_wq(), just use it.

Hi Leon,

I noticed the workqueue is declared as static into a C file. So I
changed it a bit, tell me if
it's not the right approach.
You can see the diff below:

---

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rx=
e.h
index ff8cd53f5f28..c56bae376c7f 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -121,4 +121,6 @@ void rxe_port_up(struct rxe_dev *rxe);
void rxe_port_down(struct rxe_dev *rxe);
void rxe_set_port_state(struct rxe_dev *rxe);

+extern struct workqueue_struct *rxe_wq;
+
#endif /* RXE_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c
b/drivers/infiniband/sw/rxe/rxe_odp.c
index d440c8cbaea5..ff904d5e54a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd=
,
               work->frags[i].mr =3D mr;
       }

-       queue_work(system_dfl_wq, &work->work);
+       queue_work(rxe_wq, &work->work);

       return 0;

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c
b/drivers/infiniband/sw/rxe/rxe_task.c
index f522820b950c..801d06c969c9 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -6,7 +6,7 @@

#include "rxe.h"

-static struct workqueue_struct *rxe_wq;
+struct workqueue_struct *rxe_wq;

int rxe_alloc_wq(void)
{

---

Thanks!

--=20

Marco Crivellari

L3 Support Engineer

