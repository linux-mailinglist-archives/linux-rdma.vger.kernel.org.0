Return-Path: <linux-rdma+bounces-20263-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFfJN5dG/mlFogAAu9opvQ
	(envelope-from <linux-rdma+bounces-20263-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 22:24:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E094FB795
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 22:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8272F300F627
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 20:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048513D669B;
	Fri,  8 May 2026 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxAfLY+P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C97327204
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271887; cv=pass; b=iQC/6RfoRdAEiDihv2P8w3U686VPN3/MTXfMET9gdmoy2LNs5CdTL9DfV8hfXl41WENF5l15mfoFiBrD4DsVAPMklk09KJugtC9uYXby9hCb8xzHgYCFGsEE3yHYLPdLZ0LUcOvxKNIWVeMthfis7hka4SPO9shRNH8+WjFBhQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271887; c=relaxed/simple;
	bh=9sUnz/DT8Bg4OZT9DrUCnuZEgRd9K0zXwhF72uKFtis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLaLUZR5OSNtogmvuc2PcVowxVT7ZzAVBwRuS8nqcwRF1Yjtnu9JCdi4ylGeKlZ5EzA/ne2Qd0QqbqyWZYOQ/dxwjCGUt8sLQIeyQmpuIADuQmMVtoFo4tcKolk/IQykCnDUvSDgOB6sT/L0NdIqs7z6gjK3alNTXdnvy4dNlKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxAfLY+P; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3667cf0136fso756968a91.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 13:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778271886; cv=none;
        d=google.com; s=arc-20240605;
        b=Zj3aXMx571bvluNHNFzKb+b5+5Y62RcqASrPDWmu4oj+SZLqPvxoqOanC/kVBBn+AS
         iSD17n07gfdMdIPYtC79WK9aXMe8uqcZ4nbiBwLIkU3CJaNjT+SipiEfgyZcDvBqUW3v
         Ikqe7w5Ast7Eb3dYI2KzVM1mx7o2yPrAudMi02wrw+LrHJgbx1WaQhm/Fx7Lx0Re4VD0
         zS8wIjqbsvq5qDDJpvDJQqgqdITCM0XQVJIjsY4l4YQPWNNlyVFeC+PS1TH56XL2ziwx
         onKfocjNyVLvg9mrCh3TQ3P5Bs+hSCyiIm5L0L79MV0QN1s+zfNChyPIO7XVryNG4bdp
         HMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5w2x6T8Lq+/UpV02TIL9fZSvdeDrUIRo2loFxNFWR1M=;
        fh=abx1VRU+UjbwRSxK6PqZS1cVsRpOAp+xuyRL9WErrrY=;
        b=YoRpTOgC59yEgY5AuoZ2lZxz0nlQjfGH7+j35Ac4ASod4eyjpCcQUxJX51qxvGnCiM
         f1S7H5zIUC2nmLLskqIZLiFxUTrz/WZBOM+Ij4QfbxgbLIM02q3HawQRg+cDjz2uZsAY
         SkxYS/tWeSevwkOBh2vXd1SXHdfdfmhR/ILI4UdXnVRvdM7MrNTKtA6ZspSThzv3e9DS
         e0Wqr6YrzcClKyzapkxD+ps3rfgjyv1uPjQMAhij5XCa70CzR+E9bxMPfq8pw3Eukv1o
         O7T65qBzxrPMkMB2skUlEXHLUDVySm0IJF1BaOXrWyP6/Al0x9WwWNFQ0HgvR9L+eWuQ
         nzWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778271886; x=1778876686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5w2x6T8Lq+/UpV02TIL9fZSvdeDrUIRo2loFxNFWR1M=;
        b=bxAfLY+PCt/nzLRzSi9YhRII+R8/ZjKZfrm2PmxTQMbG/cd+a6D5cOgDfe67ptEP3n
         QoOiyETFsbJJdIxOMBqlKBHTx581WJByL8oDVJAJgj1l4TC8wjn9H3badD+NKFL3ZIKW
         5SK7QcEWQLwRgJUIGa/6timocgOxwjC3dJeT6UL3sZO5oeHq62sOhdVrqiksPjYArDCC
         TRCB5P+3+/SkRJln38evN6qbb7bHYQod9dm3pg06QGb/Q7ZLvZQPA5W29c306yJY+NJg
         55vKSkkfunYYwoXDJqjC3Zb7a5CgekX1FdsOyhtJbkFVo9RK0Uqx7IoWcrJQzAWxDrLF
         Pjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271886; x=1778876686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5w2x6T8Lq+/UpV02TIL9fZSvdeDrUIRo2loFxNFWR1M=;
        b=iRg8pR9PqYOT4EwuMlRvcYjdE7GYphNlg8p7Igu9dxIEL/rpejy/nQi0euO7cPUB+8
         DSc/eSVeOxMkap2hYwxYdjNJ+/FaXzk6gQrIxcwkpKwG8tM8rjpxBqnYqJA5c1cInQNT
         mu+o6aN2b9IUIL7Nv8OX8xS/yh0axUxmhtHVlkRv1sm1ADwc3uMEc1CmHUV2JEEZWvzF
         +SRKL6yPyV3V97WHwgWLX1eUP+hSjXPQ8bM3shPz5n/vah2esEcVAZs3WRriZ6513K/U
         LtAejWtA6LcR7eOt3Mb2I5U6H4P58lFFwGdMPugFqX1VwfITsbrPWANrl/KyratZz5ZU
         rGyA==
X-Forwarded-Encrypted: i=1; AFNElJ8ySFpf5q81IpL6NPjjMhcWhS0mRbpIK/lJnA3aUQB8EqiTxekjgm0evvBnRIpwF+TRtsJOZzTn6SZn@vger.kernel.org
X-Gm-Message-State: AOJu0YzeEW53ARkxKedB5oYcQyYqxztRpRhEP065Rs9RfcfC+pmLO7hG
	AisBlk0oeGy3PhwVvxggpJBqFP4XP4Tm/fxo6KtJR0Jch7B6FmEVUBUDrjqa+Jm5IzVebN4SSev
	9VJhcffUzwepzqmEsImHWizh8E+kHgmk=
X-Gm-Gg: Acq92OGBp8U2eLUuKbyheODsKmCQLaz1YorAweuTfyYCc+XdEym+R29v5gmANp3CaCK
	LafZYKs+YN0JtIBcKFEw5zkd9aqeoZvjKOfthGNrDsk4ULBCAnP4y/CMtn6e61HIpQsvPsWz5Gf
	lYzVi6aCAGwxCbbKVPpn579MspfCbhk+75Mcwx+laRXhvbelJNcZ1eVs8x+IEmwGokapQagURn9
	UJC+vzsT2wVDSs/HqNSbMIsGO39pzFuiNpl6MldmzmmRhtpzlmGq9EpZpuDll7XF4R3GXUC4mne
	Wu29Zb8G6r0awo0V8eQnlPiQxKgepYPoU/7xzxMhSy13g46Keb1XH9fvsXWY2cdrY6gw5En2tcI
	baTX4
X-Received: by 2002:a17:90b:4c07:b0:35c:30a8:31f with SMTP id
 98e67ed59e1d1-365ab3e5b2cmr14187007a91.2.1778271885817; Fri, 08 May 2026
 13:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOOd5ej7=KFT8+JO8D3g=QnnhJR2+V--a+JSKcpuxUt=tyGyZw@mail.gmail.com>
 <2026050818-divisible-unlocked-e1f7@gregkh>
In-Reply-To: <2026050818-divisible-unlocked-e1f7@gregkh>
From: Henrik Holmberg <pomzm67@gmail.com>
Date: Fri, 8 May 2026 22:24:33 +0200
X-Gm-Features: AVHnY4L000ejPUahALPi3KsJnxCP5RECGkpX1ZTAGMQvqHvEFNFn05pQb9w7A8A
Message-ID: <CAOOd5egJUS5THB4_Rvkkd-SNyKeox2audsnuEm-mz3NEoPc2Og@mail.gmail.com>
Subject: Re: [security] RDMA/bnxt_re: kernel infoleak via uninitialised shpg
 shared page exposed to userspace
To: Greg KH <gregkh@linuxfoundation.org>
Cc: security@kernel.org, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E7E094FB795
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20263-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pomzm67@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,checkpatch.pl:url,get_maintainer.pl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,defensify.se:email]
X-Rspamd-Action: no action

 Hi Greg,

  Reformatted as a real kernel patch per your request. checkpatch.pl --strict
  reports 0 errors, 0 warnings, 0 checks against current torvalds/master.
  get_maintainer.pl was run; full Cc list applied to this thread.

  Patch follows inline below.

  Best regards,
  Henrik (Lord Ulf Henrik Holmberg)
  Senior IT Security Researcher, Defensify

  ----8<--------------------------------------------------------------

  From: Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>
  Date: Fri, 8 May 2026 16:14:57 +0200
  Subject: [PATCH] RDMA/bnxt_re: zero shared page before exposing to userspace

  bnxt_re_alloc_ucontext() allocates uctx->shpg via
  __get_free_page(GFP_KERNEL). The buddy allocator does not zero pages
  without __GFP_ZERO, so the page contains stale kernel data from
  whatever object most recently freed it.

  The page is then mapped into userspace via vm_insert_page() under
  BNXT_RE_MMAP_SH_PAGE in bnxt_re_mmap(). The driver only ever writes
  4 bytes (a u32 AVID) at offset BNXT_RE_AVID_OFFT (0x10) inside
  bnxt_re_create_ah(); the remaining 4092 bytes of the page are exposed
  to userspace unsanitised, leaking kernel memory contents.

  Any user with access to /dev/infiniband/uverbsX on a host with a
  bnxt_re device (typically rdma group membership) can read this data
  via a single mmap() at pgoff 0 after IB_USER_VERBS_CMD_GET_CONTEXT.

  Other shared pages in the same file already use get_zeroed_page()
  correctly:

    drivers/infiniband/hw/bnxt_re/ib_verbs.c
        srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
        cq->uctx_cq_page  = (void *)get_zeroed_page(GFP_KERNEL);

  uctx->shpg is the only outlier. Bring it in line with the existing
  convention by switching to get_zeroed_page().

  Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
  Signed-off-by: Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>
  ---
   drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
   1 file changed, 1 insertion(+), 1 deletion(-)

  diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
  index 7ed294516b7e..365ec2767d25 100644
  --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
  +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
  @@ -4638,7 +4638,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext
*ctx, struct ib_udata *udata)

        uctx->rdev = rdev;

  -     uctx->shpg = (void *)__get_free_page(GFP_KERNEL);
  +     uctx->shpg = (void *)get_zeroed_page(GFP_KERNEL);
        if (!uctx->shpg) {
                rc = -ENOMEM;
                goto fail;
  --
  2.47.3

