Return-Path: <linux-rdma+bounces-17246-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB7aJ2S9oGkDmQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17246-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:38:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5E1AFEB7
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 698A6300D356
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 21:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074E3D1CAD;
	Thu, 26 Feb 2026 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfBUYGRA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20E368955
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141919; cv=pass; b=GASZvnvjMxbM6V1NWJiOHezzzIx8fqPvhLEE0Q0DT7yD33wj+/sbLxQu5P0nGl/Zo3FGSpSqyDR2wN6wJGV4gvTlaqLo+g121hKTxdSuX9t6jK+uzJkNxlScT72g1O4TK6QPXRg2NgRGE0vhvdAGNrfE+ck3yLvblVDL5W6SpWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141919; c=relaxed/simple;
	bh=zqAM+ZHh4IHGk13CuTajpxb3XrzZfSROa9EbTFJFJS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhsuUhh+SVz1NNnzCCYoSqXzakIatYHhaXNqAT5atukvLCI+BKm5r9UkGFmsQXSv/hFnBCcI+I9DowIXwgLtETqrlXV5TBay6oxUVuzmX2L5vanAB9q6Bq3XcZAsOLLnEKGnu932rNGWLedVRGnRH5jvNcXo7Q5ukPaztUVuxWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IfBUYGRA; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so215118166b.2
        for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 13:38:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772141917; cv=none;
        d=google.com; s=arc-20240605;
        b=Awj1/tp7BD7WQ08TJ3mlbnK58WCOjb0SuQa6QdLaU353wQBaeqIdZxd75JrXCplKi0
         qSWpLbyjdefNnSFivcbymEc/dLygkaegp9E/GOjagZNzCuvJAjhf9NZIK96si70oBOwZ
         /F63RuBt+UFmLrsmvP6ywanIwVcjS/r+bl9e6s5B6FwB/oCzXo6g3VdRp8b0eKTTyLsm
         i85Gzud0esF6+sl//ltwk2fUOOVcle/W5UvSVLWxyudTfWiynrUyl4kTIblixjDvcQ+T
         /L8uH6cT4CfEouDet/1wz8qH33SFEoJZXi1N8DNGnxj8NI7GUq64hWjnyr1DW/b4GpBd
         7mBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zqAM+ZHh4IHGk13CuTajpxb3XrzZfSROa9EbTFJFJS0=;
        fh=eSfziUVxnLATrG22uv0ytdLIPXsojS+zz9JJaBRxgis=;
        b=TzsUe+whi7fAtBBw3dbKwPI/Lcgov4BMwa9QX0taMFmhiOPs99cBfOUBTV45ntIHdU
         O2WO/whb2Wc3a54+/zdy4lFDC/AAV4kE5wCboDcVNZT8zJAKEn3FV3fP59uekHdrzK49
         hKhEWAKW1rxA+zVC+EFb3diKthKQpdTn7oMtRLboWd9xnHLjJs4Od/aCscY2T+affiA8
         zlwCUB4duKpUg4S3g20RRyGib5ydOyZ3Y4sQ5Kmgcc6dFSkoOk4KxtQV6y/nKGtYme13
         J/PIFdbJNXh5T9s+++mdVtZNzQAyLS4QWq9mn4eBL/NOxKDtEKuKYPU1BlG+CsN3ZZCh
         CWXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772141917; x=1772746717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zqAM+ZHh4IHGk13CuTajpxb3XrzZfSROa9EbTFJFJS0=;
        b=IfBUYGRAyYMZOQ0FgM4qGOSPhbwwhOCunDr+aHdbwl4443d+BEtzjDeUQnft4DFh1b
         2xQ+eyaA3vFJV8GJFtVgEXn/lGGNbzKSjbHd/hDxaIOd8hl5QIHNG+OsqUlB7p0XSciK
         HMjFIGouZnAO9vxnn5F4dnQtkHiIuIcYX2MO1KXskOusRZch4vjUdJi0BYIs724T77xC
         KQXtoMO87bWKFoPmEDJI26H27ldSDoIBnKQid+73cQzpEsKiJxIUmcZ1VoByk4Ge+jpj
         z0m8v0keC04dDb8819DaxzDFLNB5/UVI3rbO4U+V5Zcy0lX9JjW5P1bEoWyC3Uhck/l1
         TS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772141917; x=1772746717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqAM+ZHh4IHGk13CuTajpxb3XrzZfSROa9EbTFJFJS0=;
        b=lNFFmYn4ckMkodviSRJaWoBInHhxKG3apxkuIxgtB6LRPr3lZ15TxrJye1er11X0UF
         1Tf9RlIV/ukv5koYT8kIofp5UljyDkumEoGf7M0bipl02pnFZiHvdCHP27UIWnYMAhDA
         V43RWV2QSjgW5yTG/tlrZzCluG04zFuB8lIjeziuHkSyCDhPTrJAZ2E/PLXlWJr9Htln
         yFV+fwD4YaoIi8d4pcXUGGHtzXnDLOZpFc92pEXVE06hZ1sqoyG3E+IjIhsky8EcVG4a
         EvqarhkWIFAVh5b/sqpEbjDmU0TXFi/pON70mOkTlPYV360E+0aH/5w/jo1z7dQ59OhG
         I92Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1BVxV+aFt9J6f9M3mLbiGgcK6kM5ZC3Gq4+tOfoWngOtd2Rk3RyY7ntkJm4/jgTh517otgsPY8xRO@vger.kernel.org
X-Gm-Message-State: AOJu0YxuWtoxw065hkjvgC5V8YX6W1ZSy/hgYA7Uq4ljRcXiaFIlhcjs
	5fY8nj08w6pOZoM4f/aEII2mB5UWR8mM9jRqTaAseSHjDoXfu6fIQq76iPVzJ+wGJ+MFXIlc+mo
	1F5ZFPkCG6NYdBxHe0kDBnHN4uD6jG4mwdBF8G6xN
X-Gm-Gg: ATEYQzzTT1zmM5vAzzmtedWpZuKLba1sQEkVrppyCLBwbA6WrkHFzjcmaxtz2miTA8P
	XH7dVSjdGz1Rj8RQtO4r0Dt+ki5wVR64epS5DqlVPpV4QmYBNIart26w+aQCQwR0kboA3CC8olw
	lIk8wntea87fBqMacJnDdzArFuKv5cwXWIOk1axIlXliW2AQ4s8LtgTdB71pG0o5k+HLJWg0m54
	pY3WS4WJPvbLK2Knnmu6FNEnlKK1sbExqNRsC0KoRpKt/a22O7hMLTpjb86rP4e1ZVhq1tuzzq+
	EhjShnc6OpzZNjs+Rvg=
X-Received: by 2002:a17:907:d1d:b0:b8e:d4ed:5ee8 with SMTP id
 a640c23a62f3a-b9376365dedmr26860766b.12.1772141916734; Thu, 26 Feb 2026
 13:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225210705.373126-1-jmoroni@google.com> <20260225210705.373126-5-jmoroni@google.com>
 <20260226085517.GG12611@unreal> <CAHYDg1QLzeQTXpCTeP5ZYcYyYLHG3yhUQtrGec+-5MzaGL-jKA@mail.gmail.com>
 <20260226194149.GM12611@unreal>
In-Reply-To: <20260226194149.GM12611@unreal>
From: Jacob Moroni <jmoroni@google.com>
Date: Thu, 26 Feb 2026 16:38:25 -0500
X-Gm-Features: AaiRm52uWpxcIkcRDdJ8XMjXUVcvbnuXIoaYAseCz5cNmy9SQacwAH_hYVCUK_M
Message-ID: <CAHYDg1QB9sPWLx34heDnnV-K=pMXniqT7qxL_CY95fi7esPTBA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 4/4] RDMA/irdma: Add support for revocable
 pinned dmabuf import
To: Leon Romanovsky <leon@kernel.org>
Cc: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17246-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42A5E1AFEB7
X-Rspamd-Action: no action

I see. Thanks for the context.

It may be hard to totally hide the fact that the umem is now revocable from the
drivers, but we may still be able to still mostly hide the umem type if we make
"revocable" a property of the general umem. Then, there can something like a
"ib_umem_revoke_lock/unlock" helper which would be a no-op for most umems, but
would allow drivers to have the same dereg path at least?

Thanks,
Jake

