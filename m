Return-Path: <linux-rdma+bounces-17242-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCyyIbSeoGlVlAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17242-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 20:27:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 109541AE540
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 20:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 416DE305BF70
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 19:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F59944BC94;
	Thu, 26 Feb 2026 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAirJb9S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00944D02C
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133745; cv=pass; b=Q4wTwaP27SNBHspr9wnsx80GS8B1+HyiN6ahkAbUnotoDqI8QVnN/4wi8WNui7uYQ4K62Xse6C15mLPKsrVj91EOf6Jcq3ECzQY8nN3rXj5ax3ruSaPNZ4bvKIL8gEixpEGqJhDeslBqiFlQReahbqEWOlPSGpOxQZO+7xUmO7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133745; c=relaxed/simple;
	bh=t8zv0ffMs7Zqk950uV0kPk16rVoZw6B/RzJHenSl6UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFAlZIaTlLf+q48nSc0gJWG4qBae3g36dPbsG1967veNNvURcRteLs8EacK/hSruKQWTegaNixyuntunf/I2K9aCVfNCRtea8XG6UB/KKYWaSj8GiAFndRByEBmxWVgbDks7uOyy6rEsy22w71OE+W75gXK+/97aByxvN5QXyHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAirJb9S; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c0e2cbde1so2607343a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 11:22:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772133741; cv=none;
        d=google.com; s=arc-20240605;
        b=kl08/xz4sSyo3PvXwOF6U2Ld2XikAHnEk8BQhmpXNJe3JVtumsyGe7KF2b2/5kZJTe
         Yi5wS63+tzSk25a6AaBg606WncGraC2wmJlZcdalfGIxRV/83KAKWRVs1aiRvtVtD7SL
         C8wRQd5yFYI/7dnOOqrKrzyW2ReGlRzruX46H3GxGIT40SrU22NCPiBGMDZXNobCzKYE
         ZtJZKHO4icCMT3fuK66FiqX6FIUotv9+hpQQrg5Ssbd1fUaX/PxeMaJ4essLq7pDbKN9
         YOGxX+7IpNgmUWZZfjSH5rS4B+aDdyoZuw6Uq/2ufZZb6Ty9jquhudszEuc3b4UT5NPd
         IbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t8zv0ffMs7Zqk950uV0kPk16rVoZw6B/RzJHenSl6UQ=;
        fh=9PwGvAksacWmrksUQyqbAPEtz/u26xrq/geysgkiY2k=;
        b=cXXySnoJg1vkAWNJI+24MUNzAwkaBmtHcgD0jRmdVO44LThbNB2hLyyLOTtBzgHSPV
         6+tzDBJKGD+Ivob4DlhEw1uJuiQ9gkrYjdFG43qUEQJ5LLARKeU+UyZGa/bDaFFlCp21
         SIXvLVNGyMfRTo43SwIpa9q/0hy5UOdH7/c8/nLRG5QdFDzfMWy8dH3mOgBEMYLcNHYo
         W+V9iX8mqSWXznVMBEV6BYZSHCZx+R/uLaelzxsZ1DEaGbohgDS1kj9JxFl9ulKvcacA
         DH1Phf0LELpdPmi0LlpWuU0Ii+Fci7Ph+s+aNjHn9srOj1qNPaBwdD+LJZyvC5TTs9DF
         8ShQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772133741; x=1772738541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t8zv0ffMs7Zqk950uV0kPk16rVoZw6B/RzJHenSl6UQ=;
        b=AAirJb9S+qSZaJv1skslt0PSUupd5JJ9QtNRA6vYWhbyCxXlDK8euSqjsry7k9hTl8
         O+BhLHccBBPRvbb+nL7AkXecsQPrhnp/1gMRKJDeXDuol8DuoYCYwg51J/nczO5zDa+K
         D0owuuIvja1vt38S9wCCqtLcwNCoKsFhv5ZQa2RD2W4FtbJVPZbxOsw6eWX+7woUybAD
         Mj72WSQ3DGjlAP1QkA8dMk2UiagtIWO6uIew+vH8rcEhfBRZk9gGTdV++btCPewh0qtx
         ejW3eErTorQsColjwZmo7fM0HxI2LIEJPSw5/RB+d4B4+K11mdJNSRbzGlg23XAgEtOp
         jZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772133741; x=1772738541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8zv0ffMs7Zqk950uV0kPk16rVoZw6B/RzJHenSl6UQ=;
        b=VeVl5cQSwGWgg98mPQ2bKd+e72s8T5DOmKVpkvtRPNrMKLuQDf678QyRMjGUVBNsYE
         IMvxPja7mw4a4aMGHK9TA324pByXh5UnmnIRdkwo+we1/SkgVf16IDqQS3POKmH3vDE2
         atzwMFmMqBmYBg1vdH4WA2lmK8FFnJSyu99hIsYLcCaLxp3aNJ8EiLdLNDzls4hTME/z
         c6c0f3C2O6vaPjs7CFU1LxGQqqMUZjsuTX6qOBu+zm5EcFN8tpKnOK2WK6vWb9yyoton
         FTAxIT34ePfkdW2RkiuoZ8qeC53dNvOk5vmwGBj1+37mkZNK6WEPF9q93GYWRbBsB9rk
         URZA==
X-Forwarded-Encrypted: i=1; AJvYcCVwMrSXBHU46HATGZp6Fpvik2usz81/zpuWfHMHKDRx+XeyesN7xVq7+2JKAlGNOXAB5ItJEE7BbyOe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ovlXVavnpqb0YZgEFEbfoHtE0mTQW+Kr9jAOLFt7bGPmgvBs
	2bE65VZ2yTBpIV2vRbznj3mNigpoD2uOl8ImnRtTwqVZV9+Xw1DHlyuDqabgGULSJBpP1dVPC4g
	wr1ZoDQcZ1eyHZb0BZ0u1lTC25f8CUNhx366Zo438
X-Gm-Gg: ATEYQzx7l+DcJBdBEsFVwOXWnT+LIpYygHV37GiEiQ32KMA2ok+e/zjWpCS3O8BuOv7
	lQitmZ+OaZwAIoiFXkRxr69dbbrCilPyCn0yZ3Db99FC0ezW4KmqurPgzFKC3BU1g+rD1J1bgru
	EbTocUGt4J2KwDjEn221dXJOSoGu8DCYtZnv1cgVWnhC+o5aQy7uNTGn6FeFr+DWyl42RrRUooS
	NIYCoCawK6ZXM88Qe8Zgwj/FQ8O9Xbaq7E0U5zT6kKsAOEmLcN2Nk7YirC58Wvf5hlNvnOwMuKb
	niVmVluC8ldgyi/Dz/g=
X-Received: by 2002:a17:906:fe09:b0:b93:6bfe:4f2 with SMTP id
 a640c23a62f3a-b937639ba4dmr4051766b.17.1772133740525; Thu, 26 Feb 2026
 11:22:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225210705.373126-1-jmoroni@google.com> <20260225210705.373126-5-jmoroni@google.com>
 <20260226085517.GG12611@unreal>
In-Reply-To: <20260226085517.GG12611@unreal>
From: Jacob Moroni <jmoroni@google.com>
Date: Thu, 26 Feb 2026 14:22:09 -0500
X-Gm-Features: AaiRm53K34ON29f5Km44UOiuN7lWgnCGA7AEQEV3FqPAbC-ObtVT4JtE98275h4
Message-ID: <CAHYDg1QLzeQTXpCTeP5ZYcYyYLHG3yhUQtrGec+-5MzaGL-jKA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17242-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 109541AE540
X-Rspamd-Action: no action

Hi,

> I wonder if you really need to leak umem properties and can't use
> existing irdma_dereg_mr(). ib_umem_release() handles both regular and dmabuf correctly.

For dmabuf MRs, we need to protect against async/concurrent revocations. I am
currently relying on the ib_umem_release to do this since it causes a
synchronous revoke (with dma_resv_lock held) and also ensures that no revoke
callbacks will occur after return.

In the normal irdma_dereg_mr flow, irdma_hwdereg_mr is called prior to umem
release and isn't protected.

One solution may be to wrap the irdma_hwdereg_mr call with dma_resv_lock/unlock
if it is a dmabuf MR, but still requires a bit of special handling
compared to normal
MRs. That said, I could mark this state in the internal iwmr rather than peeking
into the umem like this. Then, the rest of the routine would be
identical for normal
and dmabuf MRs. It is worth noting that the ib_umem_release would
still result in
a revoke callback, but this callback would be a no-op because the MR is already
deregistered in HW at that point.

WDYT?

Thanks,
- Jake

