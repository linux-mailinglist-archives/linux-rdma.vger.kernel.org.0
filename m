Return-Path: <linux-rdma+bounces-16533-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELL1OHF0g2mFmwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16533-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 17:31:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B009EA45F
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 17:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B12A1300EF96
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EE74266A3;
	Wed,  4 Feb 2026 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bpSnP2Ya"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A752421A12
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222354; cv=pass; b=DPGT2EPh+BEbdgiqG0HHK9P2ze8Gbf0aOfCyfdHfhRh9mZW5Rn8HzySsGQeK6oT+kl/SDBmuaGqyp0sZqvzXtt9+CVl/8gxJDIp6hJt9YczZaX2MeytZrLDejirRd7NyQ2PHbs31kr+NZUuTN/2wS3op8UqjrRUX5JraHn+HeSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222354; c=relaxed/simple;
	bh=shrshq2ZUQT11vGFLIFL9ZaIzfvkU7uGAGqo6yFYEA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGdWLx7xzuQnuiElSLvh1rmwHXq+PIVYhi7ZWIOfVqGrJ8TT9X9dVEkxNlFQ1wMRVMvC72N5grGa0i0mjg4HlHwbRm4loCC0Ok9PEMjuaOu++Xmfith3UvJNu2LGw2hd0rKaOp113zJilYdgDvjhnVLPQ/L+14b2EGgZc+JvMiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bpSnP2Ya; arc=pass smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-56638fca064so13740e0c.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 08:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222353; x=1770827153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shrshq2ZUQT11vGFLIFL9ZaIzfvkU7uGAGqo6yFYEA4=;
        b=ZUv4fENt6wLpk12n4+9ez6v3l0Mw/pG4J6KJpj+nAQ+p4vi8p5zc2ZSwgl6fHAtHj/
         QNGl4x/s9wuaVVwIL5IPxfrz2lKoLTf2YME2c5VPqBiDE7Z2VXNLsRo3y3TnspGdbceY
         6Zfy7NcHmXA4iBR1k/pXHzltxmRgG7EVSf0XVsfIC/DQbGZJiTJFTnWb2Ro/VTOeBXVX
         bXXqYLXjhf6p+yDGt1PNvG4txoi+jfPlC7pCtNUoYknAijNtllNSzE37+oqbtEWpRGN0
         rRQUpiRsN68d49PiNhxKrsaPjVNHj3ZSN6CDiy5M4umvm3LmE9GonK0GGkKr9tZFt6tu
         Fagg==
X-Forwarded-Encrypted: i=2; AJvYcCVqixmOut+E2sHU+NzCj8XNylOU1IZbwdaUtDAEG/1nERFXSFLTCfmup/c4Dqg5vBWpC9SP1MEwb9YW@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYe/qEGAihvCixwqLnsJJ04fJTXOUXhMy3nkGl2HiLOUH9rTa
	Zse4okOD+D4zUY/jdgFzy1ZpgBOB8UqM8RcqIZn9IuhgBDKpkHm9kJ0tfoHv4poWEcivSp+HfeB
	U7B7fawUUoWil9Cc4liN5gh4g6rznsEXb15yS7zYF+WDUvm7g1OYXOFKR9ZFWj5ajR25Cv17ioN
	PSgMiEvnObl5drXFBYTCLVEDQAVJXu5gjq9B8yLKoP6w5Jbmd9pj53DJMmFcmWvE0zODFFUfCM1
	Zg0p7hUtNJl/u26S859UPzKttrZ
X-Gm-Gg: AZuq6aLrdx5jXpg1yFDt6n0L3kLHHOqjr5OAABuk8r3uNW2ClFg2eeGL2W2rZijPq81
	qEYu69BOkPBAKnwj2dcX9W50tJuuGyq97IcFF5luCplKQRcXTpP93xa4IyeFO9FYpXvxIuf3kdD
	ko1G2bsYGHw3zdzpIP+ruMcqJXDQhhn82stR3Ysv4jrmwdoFRBO+mn/P76WdTWlm2Gz5SKld+3B
	F2Hay+I4O+CJWG8fmLid8cPYznZtZ2D6WwWkDyjTp1R5PKfQEhoqzO9cPl9e2YuXClOi9bMQSx2
	zkK+IwUJzRUM+IqJ4nZuKKdTAqBx+4pArBnp0i/Y1AY3vOtsZUVR2HK4d/7/WoSqJL6k1ZsQ9CU
	/oZ8HzMdxvFXuDGZf3d+nEfWpBkCAGj9/JCjTSFgijnD0q9Le+aIfZd/amZJhgT8t2fRGbRcXYX
	k6AKqtLGdKBxkPbPYwT6WgmpG/n4x4mYvjeBfa+0An08szApDbiCFbNw==
X-Received: by 2002:a05:6122:320a:b0:566:221a:ac30 with SMTP id 71dfb90a1353d-566e80b5e9fmr1136982e0c.12.1770222353301;
        Wed, 04 Feb 2026 08:25:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-566e7f66e7esm352264e0c.0.2026.02.04.08.25.52
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:25:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43591aacca2so34006f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 08:25:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770222352; cv=none;
        d=google.com; s=arc-20240605;
        b=VQ7Y92vrGt5K1II5sGRx0+HZtZBkESIgM32hjPicpyVh+H64wK1WHcPbzrshtp5t0G
         Szzk0n1YzuyZaO8+qCzjXLM1qaf2TXUj6foUApRnvAyv5ppR2Ba98NfpXVdgUP9btOS0
         aRYDMRWvGuv+W6JmnhvOoKer758lz1oa+01tFCT6tUsXKKjfBAC87/hPK60a7VjBAuc0
         5Z4NCFhJcPejyUgjyGvravFsG9JoWGhU06RYCFjZpojDbaayVKstGW2I4zttHoHLmnD7
         i6noau7jp1kMumP2vzm2AshsQ/EUxnm501exrmSNRsJbtKXSOMghesFc470JMa69zydh
         PaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=shrshq2ZUQT11vGFLIFL9ZaIzfvkU7uGAGqo6yFYEA4=;
        fh=QnmLofDYM/uKPZs10+iVhgV1WKQCUlUpeIUFpx8nJsc=;
        b=LWUYXvrHjuPHj2BkhTCfHJy3RvACKpoo4VKgOljEpsh527atS4LJ2+D01K5pWXUGCp
         oGKIBXKhu/Ymks1yiTWyA3YMhsJpfowMCgStRE33p/VbtQaqKOkXXnPJ82ZmzZVfa4zf
         p8zutO6IiPTH49v/yiiuA/Li77npFMGxQclCY77mhacU9zqK8n2ryEqbTcMrk6LH/m0a
         I0rjt4IvMevqiAnI/2tkAycEFGOXktEEBGeDuHZulIVxe5bkVaFldo929YF1J5Jx2TOl
         W6TwBtzYc6/6bmI5L1+6tyOFM69P3g3+72HLpUYopksAuNLVK5mM5519PlVngv3FhuQ0
         2Fgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770222352; x=1770827152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=shrshq2ZUQT11vGFLIFL9ZaIzfvkU7uGAGqo6yFYEA4=;
        b=bpSnP2Yaf5B6yFupiD5ivEmvgQ83V2p5xCgNkIybpoAe1+5NEwg9qFo64afPiCQ3UE
         sWlNYCABVFSTe5yisosT6LO01YqgxaKnJzOyH7mG+WfcKxHtwmeT4ALKt9gtKDvlTmbS
         E1ikJsXL1nmptHQpga63G4gkmcMIyYOWhLLrQ=
X-Forwarded-Encrypted: i=1; AJvYcCXwRrYNAK1/gLxwGdzG3TXGQBic4v8WzelfDreAxcUkGE0PlRLSnGU7htdfIcI24hIiKtbofHsRCC18@vger.kernel.org
X-Received: by 2002:a05:6000:290b:b0:432:e00b:8687 with SMTP id ffacd0b85a97d-43618054eddmr5279588f8f.31.1770222351543;
        Wed, 04 Feb 2026 08:25:51 -0800 (PST)
X-Received: by 2002:a05:6000:290b:b0:432:e00b:8687 with SMTP id
 ffacd0b85a97d-43618054eddmr5279544f8f.31.1770222351070; Wed, 04 Feb 2026
 08:25:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com>
 <20260204011019.GZ2328995@ziepe.ca> <CAHHeUGXky2H8NSWy8ZwCcqKDQEBn=CkMAzsLDT5gBFnZrn0WYg@mail.gmail.com>
 <20260204144313.GG2328995@ziepe.ca>
In-Reply-To: <20260204144313.GG2328995@ziepe.ca>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Wed, 4 Feb 2026 21:55:39 +0530
X-Gm-Features: AZwV_QhrYzTB2k-Lkoytpp9BfapVg2Rrqu6FtusUVDB-a-8KP8RD4-GjvjvbkhA
Message-ID: <CAHHeUGUeJ6YfB59heJ+PN5NkTOAXFSBLQwhS3Y3jpDSfYROO-A@mail.gmail.com>
Subject: Re: [PATCH rdma-next v10 5/6] RDMA/bnxt_re: Direct Verbs: Support CQ verbs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000079afab064a0202a6"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16533-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 4B009EA45F
X-Rspamd-Action: no action

--00000000000079afab064a0202a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 8:13=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Wed, Feb 04, 2026 at 07:25:48PM +0530, Sriharsha Basavapatna wrote:
> > > Here, I made you a branch that takes care of it all:
> > >
> > > https://github.com/jgunthorpe/linux/commits/for-sriharsha/
> > >
> > > And makes the required whole flow a lot clearer since it has evolved
> > > into something that is far too open coded..
> > >
> > > Let me know what you think.
>
> > Thanks for sharing these changes, it looks great. I certainly missed
> > the point that you were suggesting a kernel helper function for
> > structure validation and one that also includes comp_mask validation.
> > For bnxt_re, it also eliminates the need to have a separate compat
> > flag in ucontext for each type of ureq.
>
> Yeah, after looking at it the state was much worse than I
> expected.
>
> > I applied the draft version of QP-umem support patch (not the series),
> > followed by bnxt_re DV patch set, updated bnxt_re to use the new
> > helper for CQ/QP - ib_copy_validate_udata_in_cm(). Tested it and it
> > works fine.
>
> Ok, well let me work on posting this series and you can revise this
> one to drop this UCTX hunk and use the new helpers for the new
> structures. I wanted to look at the other uapi parts of this one
> today too..
Just to be clear, I will rebase and post my series after you post the
ureq validation series. Is that right? Also, what about the QP-umem
support patch?

>
> > One question (maybe I'm missing something) is, copy_struct_from_user()
> > seems to have similar logic to check for trailing bytes when user-size
> > > kernel-size. Is it also needed in _ib_copy_validate_udata_in()?
>
> Yes, that is a mistake to have left it behind, thanks
Thanks,
-Harsha
>
> Jason
>

--00000000000079afab064a0202a6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA7PLN16IqZufotgsBqR6CwiLJrMxeNMemy
6pNfKO5TBzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMDQx
NjI1NTJaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBips06+cfzSTDMo7PF5kvg0l+EzC4N/R+qtLq1vYC/EGwEzTi918Y7t2RSQkOGYI5z6BV3
xOvRFi+gsddtatUYy/pnbjMmuSMtFsHhpc5+m7n0X7xo87Dv23CsLpSP0KVwbmPCS3uhC+kdpen6
6sLDe8jcawi5F58aJeJnTDrJAVcVmeH+OE2kl/2CBMbWEPeCHjfrybTYWq1fDIvgLY8nMJjbJ4m6
UWb9vv0wO8Gh3vJ10Tq4bR/Flz2ipFgMQjEg6mSMjJ4TsePbDMKtyCBHPg1jY+MgBGgM2kLFht5H
Gez7CBaY3WCZ6q5I4fwBCFpk3MC459nHcSeehwoq/OOz
--00000000000079afab064a0202a6--

