Return-Path: <linux-rdma+bounces-5315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655B9951F7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 16:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181F8B2AE13
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2991DFD8F;
	Tue,  8 Oct 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Px+SFYGw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626D61DFD80
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397127; cv=none; b=Cn2mctRzeqNEidVxCJC6uYtMSRIuN2oxWu03jFtp905wtgmGV4UiACT1e51AArTZi8kQgmoBEMPYNvwJVI/DE1TDZcTJQYbUqpjane1782A8ke2m/Ukh4TGYxnP5kfTfB/H/K89kZIYQsIfd1Euogt7lWPaowRfDsTfmu2HYjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397127; c=relaxed/simple;
	bh=or31lcvxV+F69s0n3WoLzizqxwgrEVkivaNvw3wM1U0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=BwUtRiv66uKSddoQomZsWSAwIHx/02VoPnPT+7Se6nZw51wZ+G1xXtekOkCY3ysChZfx/X9KMoi6xPx+A5P/dqfLPST2a8roru4jVGWLkFM0no658scURSKZ7rf/EmcDHllpZM4oOFI6ACWB1nwl+oYUG+OVUolzi1XdUWyCG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Px+SFYGw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42ca5447142so8551765e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728397122; x=1729001922; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ncZXlgPn7W+AhAyDjkgpk4vrK3TQrMfTOs00NRGHAUM=;
        b=Px+SFYGw1wNx+8ttC5triGLrnDdBJo7CZqTOV0MWKWgl6Y+467VQ768zE9N8FGaoBb
         yqvUGf02Fa7IIOS1JMt10ZSRvgG1Xo9TekkF8LxkdlHbeqSBsw2ZfuJ7lRYTfaYP7QeH
         hOOskJMsfXaYS+BOe8vJxuw+NLKJ47O5qd2BXGuaxuAIN4gOaUS+mcjbWJYQ/V4a/oj9
         jMbiomkcSVw0Fslg3y2/fyc2c6XTPZCq1UwC5e1Mvhi447+suUeT5frCHEQEQy+NthDp
         kkCPHrx99FKcI12fblHFZ5v+jAFVNX+SxXWQ7e02tl/+l1jZO+zxCcdqv5Fiw2npRSwW
         5n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397122; x=1729001922;
        h=content-transfer-encoding:autocrypt:content-language:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncZXlgPn7W+AhAyDjkgpk4vrK3TQrMfTOs00NRGHAUM=;
        b=uFjXa/Kj+ti222HEubBHT5KYm4uf4Wj/8mgCXcVeoAEQxuau3FCoK2POy8sgr+a5ks
         mfgApmYxrxUPnd7aaK08233hUH/iEgCXirGXlt55AZUWM+OfP611Nk5QM/KjY0/DxJsD
         9o6L6fXHG8+HSoj5SpMbZ0tHfEBQHRb9gG25DR2zTYXm7XdH59I087AVepioSmxqYvCa
         dkonnNEmfKg8pVD5sxnHpe+nDg29XxKlvZp9VUIS7XBcOL55e3vvSo/hDCFq8J/q8211
         orfu02puR9I1zqu3TkBpZv/2qfRPUFwWIUjoaofjZ7d5F1Zf1Ar5s6blEvzAAo8XAXk5
         j46Q==
X-Gm-Message-State: AOJu0YxIUjre5MeUKTtWdCJ3xUleXbcDFiZzKMczjdKwFcAcec/Lr7wl
	ChspMxmvBOv3GNLYlbvN1pveNZuD3/IVrOt7xha410hwyoHNK1SwT5NdRrIsGVYk+2y1vm3ay9f
	Q
X-Google-Smtp-Source: AGHT+IG5cZr5pXOyA2ILPjjv9QbI4MTnU44aa4R+CQzSS5TFzYtSZUabyNqET9gnTtFCVm9/RvDW+w==
X-Received: by 2002:a05:6000:1544:b0:374:cc10:bb42 with SMTP id ffacd0b85a97d-37d0e6f2722mr4028018f8f.2.1728397122326;
        Tue, 08 Oct 2024 07:18:42 -0700 (PDT)
Received: from [10.0.2.128] (anantes-654-1-140-64.w83-204.abo.wanadoo.fr. [83.204.35.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972da6sm8212115f8f.98.2024.10.08.07.18.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:18:41 -0700 (PDT)
Message-ID: <ab31e1c9-5818-4695-831e-bb34f93ce5e0@suse.com>
Date: Tue, 8 Oct 2024 16:18:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nicolas Morey <nmorey@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To: linux-rdma@vger.kernel.org
Content-Language: en-GB
Autocrypt: addr=nmorey@suse.com; keydata=
 xsBNBFjZETwBCADEkoe7QWAXzd9xpSiPbQK6P2F4wKdxyTp6r0aN4I0O+4fc8xWXvmwOrCjF
 UsuoGZ3CxJaHgdB/3ueW/IhMO5Ldz7pylhKVlG/moUh4CBK2eRUdaG7mHID01GyJMtR3VQqu
 22hJhHPYy0erpYViyr+I4MzQA9QZLoQhSxn4imjZOZPcj20JE+lRfXppNv9g7vQiRLMcXjTi
 KcnrqG5owOi6Cn1sZ201YfdeztGxKA+jvjWO+6absTTlorIlZNGUf85s2+caGDsqa31u2DPs
 hVv5UUTy1g/5aP2wacSWI3Qm4n2MWl1aCnHN2h737PCXXfBk5iGJsgBUnSQULgdgEAt1ABEB
 AAHNH05pY29sYXMgTW9yZXkgPG5tb3JleUBzdXNlLmNvbT7CwI4EEwEIADgWIQRC0lOFwaHA
 K4sbHG+AG924JZiPZAUCY5G8SAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCAG924
 JZiPZMZiB/9QkcGfH248qvFUWZig3jssK5IgijfOFDKB0YK4e844M5C8LVSuWpu7Z+lM+cql
 3mbrikW6mlZjPEusrQ/KGvT6TdfOM9VCQWjlshMzt7uiRDdzufHGtE5hhk/67UnkEVjmplpD
 k8cb1O0VsBfGym7e0nySHTlDWqr++9EcwgV3uo4psYYEqm6Aon1yKqjbmj+vfl/C5iW3V4lq
 DhBk8w21AvNS+tdEqJzhruxuXkEDZZ07wYFS7m8OxLNb4sMzn/Nz9x/NXeweBWx2ujIERtAq
 1e/hh0ZAcoPVR3CfO2QTmfTfrzVdpZrZ8F54337ze3+BUNnrFGObQhlNe26NqNYWzsBNBFjZ
 ETwBCAC9zAzCRlTgzyO9siVLQYwbRUhcL1TUJU/FiOQWQTmL3uDdBc6MgVBs+hp82RwPbbXT
 v4W4rghBYPKdmFXvRN+jvGDLq1f2hsuCSiE1ckTMzFV+sKoWRIEC12tEpw5ncEFGm+1k/rJR
 Lk9eHxuqn+yRjPryN8CK6tK4+b4tZ2urKlP29XG+T3l/mbUSoqfjqvyeKaW6xw7ku89EX2Xo
 QWP/pm92RxUd6VDU9vpVW/T7qPZRl0wtUnDnO2wePoZmvUfEr5Osh3MNvm1myG+v4EV2Hgva
 NT6pa27IptrUq06cA6dDsIKwPtMuThJQp8/xumgl5Q9A/ErQoJTrB9rclIm7ABEBAAHCwF8E
 GAECAAkFAljZETwCGwwACgkQgBvduCWYj2QwNwf/eOIpFB67cKoUJvcm3JWcvnagZOuyasCw
 xwH9a0o9jORcq+nsJoynS/DpjUKGyZagy7+F7sBrF7Xx0cXF2f5Bo42XNNiQDE5P/VLwvgn9
 62AJ3q0dp4O7oQI8UgNmdsocQhNaBHHCoOabLGrgNobDTaLBeb9zaOZqz8CBuAiZ0bVABEpg
 50hDEYTHp4jCgWpadhAsp/eCgm93Tc+Y+e1fqtE3FmoOLxyhFa6evhn0Q1iX0kCasMZwlzse
 zqLZjTM1Koqn6+UIHXE3QaULyFKD1GDhisXxyolOB6P2TXsyfvitYdIZ3CCtI7PVDxzmX2Xk
 kvEz9bMtStoMpse9qAsmHQ==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

NOTE: This will be the last release for branches: v30.X, v31.X, v32.X

These version were tagged/released:
 * v30.14
 * v31.15
 * v32.14
 * v33.14
 * v34.13
 * v35.12
 * v36.12
 * v37.11
 * v38.10
 * v39.9
 * v40.8
 * v41.8
 * v42.8
 * v43.7
 * v44.7
 * v45.6
 * v46.5
 * v47.4
 * v48.3
 * v49.3
 * v50.2
 * v51.2
 * v52.1
 * v53.1



It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v30.14
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:20:49 2024 +0200

rdma-core-30.14:

Updates from version 30.13
 * Backport fixes:
   * bnxt_re/lib: Populate vendor_err in the work completion
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz0EQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZMfXB/9vsLU2xhCFUy0KmavURrnTNjLNYpB+gMlc
jYBn/eDElZWGVZ1IgtEhwc44aTrQyxucRwcxGtheCa/MfDQ/dbn7FjTRWeT1wNTU
7uAOdMALKIreyT+1xETYI4/z1UKz67kk7lM0WHwMIlXiiEqfFk6dAqIaNUQ1s3jL
ZDa5OOzqNsd5rK7j6jlYk44P9YF6+uEw7znQJ0czqu7+g+8WFP3UK/6UXXFsIw7H
MpEUNTMxFGsl3rJqU4AVEmNVbpx/E/XofIbZ4gl/uDVJ/7c2WwVMe203pgnnwFBn
UAgXcfaTxWWClTgwg0xgDWaAbUxkSCvm3S+YzPq6PoUPiap0SNsQ
=LWMn
-----END PGP SIGNATURE-----

tag v31.15
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:20:56 2024 +0200

rdma-core-31.15:

Updates from version 31.14
 * Backport fixes:
   * bnxt_re/lib: Populate vendor_err in the work completion
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz0gQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZJpGB/oC1ieY5IJRXCmQpUFIwLkDACN53jkpKnw1
9Mb4KrMVFPxQR60CqZBwOq95BkpBatiHJ+TeyF+g3soXeKI2XskI5B2NG9PFPBbv
xIdg756stZLn1UqVCYxBbIROhVH7+LclPv2DZodL0bvELw+ua8SkrVQYYfA9DpSj
aKhcW4iBRD1nZ3zIOaLpaV516qnuKRyySlN/DxC7fdJ75ayu9nhtaFLssY2uzanx
onJX8TGDtMCnp0jcdkoBPE1emdO82ylzvt9ZK9ieWO2tesT06Hgcm181Spx33Rm4
J3WWL4XJ6jpMaaci9hsrkqgyKXAxY4DWUBO77m0gDRoUAIuSCyZG
=0j+y
-----END PGP SIGNATURE-----

tag v32.14
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:20:57 2024 +0200

rdma-core-32.14:

Updates from version 32.13
 * Backport fixes:
   * bnxt_re/lib: Populate vendor_err in the work completion
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz0kQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZI+kCACMhQqb+u9JGeFYzPzuWCU7/+xXmC1VwOPF
6st/U4yL5TqCwCLvql5oGrj5TdcsENfzi8KfIm49dJt8KjsfxyVSr3W5y0ydxOlV
CXU5Ss789zpCtwFxd2V82Ca9kp6ZJmi+ozfG7PivHFpDy/TClCd0WojeWeJjNhio
XKHQCB7UXBChM5fuXUYi7YCsjvfiNhxiSAX8M7sThTnXMHj3GGovY8tH6ebRVVk2
b9beKld146xhOoar/V9zOsZNBZiy9QWmkF+i4h1HBERgM+4Lg4KK/vSVBEKq/Mlp
g0fYdG0YTHVOWqKs+eOB8KRhIhe3i0M6hSY1A1+qaDhe5P/01zMJ
=AJ88
-----END PGP SIGNATURE-----

tag v33.14
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:20:58 2024 +0200

rdma-core-33.14:

Updates from version 33.13
 * Backport fixes:
   * bnxt_re/lib: Populate vendor_err in the work completion
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz0oQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZGzxB/4xBZz9Wj9axMS444ouG/R/wd56RLi7yCu3
bzG4EBIrRH7raQj6pCkyuh1++mPCn7R2qcysfNUOwqgYlecM0DEdSHr460MLMXGk
oxxCl+25DGOXUSplNA86yG2dNp0WDjhDkQ4zfMZJcLTvO8pcM9nsRSClOYk2vyOM
8i+6NK2m3lwURxgXMc3PV4qraAc2kEkM7jJ+cnplEWJM4nypGNZXP4ogYbl7+6zz
YYzRVo3OqNFrVCVFTGz1rlrrHVR95A5gsfb1myneYM+rGGpcZhr1QEzS3+e8aCSV
RNGF7kqcBfasxwPkc/gg4yxLbwCzfBBIVQc47rjC/iRIbLsxG1H6
=qul0
-----END PGP SIGNATURE-----

tag v34.13
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:20:58 2024 +0200

rdma-core-34.13:

Updates from version 34.12
 * Backport fixes:
   * bnxt_re/lib: Populate vendor_err in the work completion
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz0oQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZCLmCACCGs7fTZ5U/beY6R0U9DMtajrqPI2Twb9I
8sdrANnKk/c/soV+bprpfN5mdj3ieKPEY6MgMoKO87b4zMRXSpt1ZumKKaFsM8IJ
2D3AUWhYw5fElye6vixBrzBN2eH6O/8j3fjQLa+XLY4hd53flNZYXotSrxV8yIYe
W8rClRqJr8IKxOuQm410DHS+yTyj818Y1vJ3KPquYNWN6790LYxF28o753MBxFrT
pQ5kpAxt0r7DQ2nSCj0SEEA9U4KYV1g3qkAbK4zTRUwlqiredxRTy3J29zOuE7z7
rPpOEEyd4kt5TH3MCGa70xGnWUdrTltthZLm3rx6HIi4goR0QVwt
=WlGH
-----END PGP SIGNATURE-----

tag v35.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:20:59 2024 +0200

rdma-core-35.12:

Updates from version 35.11
 * Backport fixes:
   * bnxt_re/lib: Populate vendor_err in the work completion
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz0sQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZPh4B/4vmCMnk97rOnsbhdPOSwp/M+WU6R3gyRSi
4UA7Gxg3z3A2HgsHG3UZhVotYGL1hpYOVkbAXMIHxt5BQ2Yyh0cdP7qyD565ei9T
KZQS2wYfp7UmAHp9F44xdbfLqaXmEucEy9mFuojt3FSoWR3ggh4heaYd0z2o8w6D
YnQBCcNngLth6s3AC7dfy5sgzxZBr3qGIHEo5sjeJEOwAg4d0eyCpNUM/aTlQ6P7
/C2+uGpaAMiUHK7XdhqRiFmIF/FjzNW3JHiFgykx48ukjs5T8Pud7Q3ifCh7J0FM
XqckB3I0X3CzCJIUmSjKPiFgA7SXesszWprwepjjPWTcOfBnwQGX
=vOwg
-----END PGP SIGNATURE-----

tag v36.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:00 2024 +0200

rdma-core-36.12:

Updates from version 36.11
 * Backport fixes:
   * bnxt_re/lib: Populate vendor_err in the work completion
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz0wQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZMUtB/48l2xsZ8ApOLbBnxtWx+3LKFfNSAgMXsA+
FD1oWcsuv4tr7vVlBIhf2Ll1grQv/o8sOHSJ0IRZqWRy33z3XKYIpNZlBgX32n8T
qUh6k9LfsO/8Sg3iceXlDhuesNd5k/zwjzPlRSxSCXTMs3L49roRbuhWvEyuCAda
eX1SHcPz2Tovc3p8UUEfBgxm/eVfi7krSoJoLR7dKl6rkt7LRT6iGpPOMQ9I+EaH
4xCp/qF6VpmAQwab6A5miIHkMdMJFUEtOqR+QKuwLmaW142TpK7M2tvkTGurrCtP
0l7ipH30bSshFRelMS3Uq6EXrtstatleBNpxzNHnXLSj+52NAwa0
=D8uS
-----END PGP SIGNATURE-----

tag v37.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:01 2024 +0200

rdma-core-37.11:

Updates from version 37.10
 * Backport fixes:
   * bnxt_re/lib: Populate vendor_err in the work completion
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz00QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZM6QB/9lf2qgfCwdfxJl09k8j0M8XTmqCwDVdoBi
sV73oVmgXPOPdp1Dvk0UGHfGKjXxj0yrFW2n2LSeN7xf8YPn2mkkfX6Z5l6JR7rO
eTwoYtZ68S5wMYcNpxLDEZ55pAenHA6ibqCHb5ddRF4sHJaLzNYnCSAPMWNC0wGu
KsvO1U6ir0/8iEK78gRgLU+5eJ09OSPLXmET9+Yy6hw5jPCkZepoSF/F4dO3nSju
C6hzi95+eUF6QqKwvbECEWmf9rdyB2UnhMlvqklNRA91cu757cyvjVdftTxMcC+Z
aQ20BKGeJ9ZfyGwc8aE2a3uiPOBgoFXErhzkqw512vmf+541r9Ze
=fH0u
-----END PGP SIGNATURE-----

tag v38.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:01 2024 +0200

rdma-core-38.10:

Updates from version 38.9
 * Backport fixes:
   * bnxt_re/lib: Populate vendor_err in the work completion
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz00QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZH5XCACXukSl3pcdPUhsrP2JBY6CoRRck5ziSjKJ
8Imalgozdyo+26KqWPH7jL+ArR/c2gJh0u6IOM+KanbUTho7AHnz+nq6guV10iOo
Yvu3ClKWbRsXj20zhtPjjIENePmF2oYtEl3K/PNgZsWGoKPNlTMh88PTPbo1P2Q0
35Slw5/O1f85NvhPZwHfAu3MoPuDvakT+iNf06roDRgoPgmnoB2f9rqdfsA91gkO
R4jR7K0rNJanEsLJykFRIoOYt7wdf1jErBJUphCslHJkK1oLMXR1AQSS//ltEIS2
qtEFtCfT737//RkOr+/niORCbczt2mfnvaAG07QdHdLJKPJwY3Iu
=Np0/
-----END PGP SIGNATURE-----

tag v39.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:02 2024 +0200

rdma-core-39.9:

Updates from version 39.8
 * Backport fixes:
   * bnxt_re/lib: Populate vendor_err in the work completion
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz04QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZD4tCAC36u7OOS7ATrlCpbp7jTI6em9w1+VRvn8B
jjdOAP0Vp1DlAnHSPmu0qgRxacqT/zDvRZVK1kkXNxAe0FCfgvESHqSOcd/5tK75
g6UyLovfcbOe3OhX0xrCGmpNPW/9ObsHhUk6Q1ls4jf9dKL/srizv03KkG5GwqbO
NMsiuHb6ahehqGXpa6TlAOJV0iMFSkrrrxOubqVWBxUXX8srGOfC+Tka5BhT6euV
fld1Fehwgg5VP3MvAYEvHQC6yCVs0ptHsfOJA0ESn8ZJNYJ/8Jk+q33gREZD4/3b
NPjyRJ7UHvR596yTEtL9cZRlzdFWvMISyxumBthREKg0Y/HUE91E
=QYFq
-----END PGP SIGNATURE-----

tag v40.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:03 2024 +0200

rdma-core-40.8:

Updates from version 40.7
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz08QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZI4ECACEKZfeDV5ziChZgVXWGyq6w0rq7azfjYtO
85nrZE+4hSRNliCxik784hXvh4AGBNfkk+kHzTo0WvyNBKsoXJ01LKZ791c3SK0i
uR5pJPmUTsiYSbh4dzhVONcLy8/7saK09pxLUgNn+u2CwRydfY5u22QQnLl/eWnj
0OL6pCcPR2mgzGkc9efby+qcRuhgZMGAaNXURUi0921beQqvXQySgxNfdr10Dvv3
NvmE7sD1eak1PxXb1WRQntZb5gCPKBIgSMEN9HEaCaAFXgQxuO5qJr1r9MnBVheo
GkKWuNdjh0xfAGu3nPs7+efzRu+qEX2belbT6eFd66FM0h2cby4s
=09o/
-----END PGP SIGNATURE-----

tag v41.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:03 2024 +0200

rdma-core-41.8:

Updates from version 41.7
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz08QHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZAxfB/9w7GrhJV+0gwdL7zrEry+XFtqwkYbcOKBt
dcZY60m/OzU2Px09SD7GMIS4BI1Jq6ACHDItjbMFy2+h4KMRYG4je5GrV8+RJWAX
DydFEbuo79bkhYOFjBWJ6dZYBpD1nLvKz9UhUyRoSEiYsT6BGGdTBqHTmDkGbI0E
ULT07TTAhK7jZuBJY2s4OVguc8IrmzvFVMEaFcXmAbSuOEcpt/muTSe/lDz3k0gV
QnXa6/Hk32WvKi9YDWYmPpqHq7kYZwMGK+pfdpbjDPk8j1vrLb6X2erMdKqulTJa
XOvbg6/wsyn5upsAEQ+WSpuzsPiYyxX0UmWVawi/wxmrlWfRAvtF
=2f1x
-----END PGP SIGNATURE-----

tag v42.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:04 2024 +0200

rdma-core-42.8:

Updates from version 42.7
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1AQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZAXgB/92UD7G1xxzSGjVBjRM9Dl7t9fPPII+01WF
yTQOnM+uujou2YwVe1GKRgJUaK7gwxZUVLm0u4NcOsMyhgMrHC6FotxkfpDJJ+ts
nmd6zpmc1qsls7QfamOg9EVPh47LDAqRnWBeD9EQg1Gf9II+2yRcXbbuSviKGdnI
9c/zmMgnLKagEROV0B6Zd6DO0OYwpiob2a7ia5yssT4lToINFFNeaxQ4ZVGgYXTp
p+XdgG0541MYJj8koMW/kWK2pgopxZuZ42Pzeu74Hl4aBzqymsijonB2zeFadzuS
DkvyKL9CiJJNisYkt0ZhkX54awLmUdV6lFRydrRI6217D+vYOGx6
=vcYZ
-----END PGP SIGNATURE-----

tag v43.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:05 2024 +0200

rdma-core-43.7:

Updates from version 43.6
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1EQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZI/2B/9EtE704O5eagynwGuTDC8rQVyiEO97dAh5
sGcVZNwEiLkWkZoyykwGk5x7AV5rXUi2loykO1MquhzfTD2tk/8qb+pRNFD3W9Qk
BcR9j6ipGdNr8Mw13u0y3yu33c1h7paROW5babqJ/PT7Jc4Or+OEtgLFkN17LeLB
jf0tEo3d3eoK66oc4LmrjwbuhGVmjXqKZP5m5lKwRDIQYe7NJ2pfBRWFgcg03CNy
o+OQAiuVeGm9NLyhPJTs7IL9bORTdapC9xDdrCSRnqfByaBFDF0GtN1vhCOyQZfK
bAEUSDLc01uRkXaFrX9TfgAoe/XEKB1EqT6y5x6ZKZHEekubUixD
=SKtn
-----END PGP SIGNATURE-----

tag v44.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:05 2024 +0200

rdma-core-44.7:

Updates from version 44.6
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * providers/mana: fix align_hw_size and improve get_wqe_size
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1EQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZEEsB/9czXPbML2dKUffbfZ4GTQWESmnvmjo7mIw
lT9Fbew4TpzgMl0YrpUSQ3KWmRKPXViwVyWr5dqzaHIvdrtlBvLTS4rICEwtRnHw
KuF9VMelxWcZL5OP6qB+D1vz0dv4tgojPxyZk2h2KAey9NxzNyNobCtenGRB/PwZ
+H8iuJa3/RpA2Qal7n+G9gjfXGJciBiqzQ6NXBtljWX4qgRI0pARu5ZiqIdM/u4E
zjCcx030ot2BpNpMZXj2ZDodIC/FubY9+JcJ3wzV/e7HAMAQs7l3O+MyiWEkOYGI
u/9uY5eyM4+g+Kfe5sTLkE8CaIc7pntqewvIi1aRXoQhbGnlUIsc
=Sr+Z
-----END PGP SIGNATURE-----

tag v45.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:06 2024 +0200

rdma-core-45.6:

Updates from version 45.5
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * providers/mana: fix align_hw_size and improve get_wqe_size
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1IQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZBKNCAC3ND6+cXCEDqxeVW3hhquE2FMsYAMHYHlB
fMS8ENbbnTDo91rOg5w4V6QpzPcSjakk/uFBG9O33L1bmXd1YhJv7a9fTNg0FKhS
nHJb56WhKz8SHvRYmbLObQt3Cl32v20wXKnTeALvr4Vbfpg4W+xVuwlCVOZD1yCC
ICHsEAuWJQajd2xdxoAk2WTJp7ntf3FXG/RcSEek+xzgyi45Mxy8VWZ0JzewMpFn
T8dd9eg+Pihebi3ZbKzUvDD10bvEnDumf1edo7BqB/+T0/Wjg0ZF5qvS3UHKP4wU
YHNJ13ErFotJLWIOPoxE/oVkPVC10KHTG4wHii2kts7QUxoq24jJ
=qoSB
-----END PGP SIGNATURE-----

tag v46.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:07 2024 +0200

rdma-core-46.5:

Updates from version 46.4
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * bnxt_re/lib: Avoid applications hang in resize cq operation
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * providers/mana: fix align_hw_size and improve get_wqe_size
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1MQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZHc4B/9MvPcBmcoWEeE0u0ugTXHYkcxOVSOIqMNe
epAvpxPOGIgCVp5e/0RqCP+W9Xh/wxhNqE5Ht4GOszaSb2PQuXTip2wspquboJjF
YobHXtRKeJEEqFY2WLJCi4LvbqgByfbljl7IzKHPCy74cbe4maz/QgeU5a4Zczyr
/FYxFUsqAm9T7Or1GUUty3SrD/Aiu85QOWtYFa5GE8pQQVRNs0lbRXAtaMsvdkGz
cpNR2Fc+uctHz/qnMjXEXOzC6tHt4/5bgrXsm6UYByVJZID+3F5LiZ1CT+rXcW8Z
+fvpGMFlRrzEIDDBG7nHO5cmhK9bA34mgI5IbApy1Ccq+C1O4mqT
=AmNC
-----END PGP SIGNATURE-----

tag v47.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:08 2024 +0200

rdma-core-47.4:

Updates from version 47.3
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * bnxt_re/lib: Avoid applications hang in resize cq operation
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * providers/mana: fix align_hw_size and improve get_wqe_size
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1QQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZBoqB/9X/zWYK5039HWIu8GAMavPg1ZQatqMOQ6D
kjC+08kurTVL+KUr9k6bJbNQ2fC/6Y575mr0BPcDdGuI/7WN05E25dBNRfs+Jicg
Da3xTbThijGUqm7Df32Bg6TrEJYX7pPwzO8ldIxs+Phbp9VVleO0O9qccn7bHe4h
HWukfjNLeO3iZSTezigm4itYPHY/vO1Y/7nI1NDZNCgeWiECt3IB42M/vmQoVU8j
QmjFOy+L4gYeQ9whhC5XgtC/6Oku7lMd3+Mu0t3Rl2+unydvtjYn/UxeSH3QyMSd
f+BdYwMjJSvDaQ4j3I0hac4lGaEP7RHnmE1CR0p1uEmxegEOTwQm
=iWrd
-----END PGP SIGNATURE-----

tag v48.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:08 2024 +0200

rdma-core-48.3:

Updates from version 48.2
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * bnxt_re/lib: Avoid applications hang in resize cq operation
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * providers/mana: fix align_hw_size and improve get_wqe_size
   * bnxt_re/lib: Fix doorbell fifo register read
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1QQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZOwzB/sFKv6Pf1bwVPRGaNnssQt8gOmJZ8mIRsb4
6KaTjf/HINtu4iDnc6GnT/sLDaLlXTgJqlNbzX58kXuzrCt+/8jH9Xtx2HRGF8I3
6yIAZ0cYZvLs8NfJp+HJGzK1E0Sfqndqcx3rDfz57vwjqaqBJxA6xwtbp9n684oi
79iQWSbDE1pLJtKajB6cRTCuUm6AJEO23Dgg3Yc66pxWLO+CBrAjKYQlA/fP+Jmp
XFj7CDVtnJ//hvQz1lpOPP8+maLKRNPU5oI15KxftrTlad9eiGzzwdT4UC8ReFBF
UlyVEwOPhTANmLUrp3PblKWweefsIBd7IPqh9Y2dyZL45YkJxJ0L
=4tm8
-----END PGP SIGNATURE-----

tag v49.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:09 2024 +0200

rdma-core-49.3:

Updates from version 49.2
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * bnxt_re/lib: Avoid applications hang in resize cq operation
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * providers/mana: fix align_hw_size and improve get_wqe_size
   * bnxt_re/lib: Fix doorbell fifo register read
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1UQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZOI/CAC5Q99P0wTprtt0kZ5Sfh/DfBBGjifviwfB
2KqLimTaoUEPUVVgCUjTy7jF3El9QrzpVY/IFhZfuqwlL5uvw3o0/2z24hfnboSx
wBli/Yka0S/feTVUWKWsTqynDrKk1HjDq1Wrxu/NvVjuS+BdGHXG50foyF0wChM5
zutieyrMWrVsctRF4LO0X57aR7+oKyh4MBos8Er1m5En/TauGkuNgi2oyoZo5HAO
XJTKsqjA7D4HWTzcPg7U1By3IPB/i+OsHhBDZH8uwMzWASBFWtZBP804dbY8Y3F8
CJWt1sNiqG23OQup4hMpXFt1e3m6iw8xQO1Tg4TzyK7yd9ip7qGf
=PJwz
-----END PGP SIGNATURE-----

tag v50.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:10 2024 +0200

rdma-core-50.2:

Updates from version 50.1
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * bnxt_re/lib: Avoid applications hang in resize cq operation
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * providers/mana: fix align_hw_size and improve get_wqe_size
   * bnxt_re/lib: Fix doorbell fifo register read
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1YQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZBZECACkFIn3H7KRF1zrKV4FPgSLk7N0cUB519LI
DPJDHZv+PCiXMpj97SAZJwBcx0vfLZ9K8xg9byAshQN2ykGgqZC4fQnYtG+3bdfu
VgMXbV02NfcIj5Lbn1C5aU6TrS9DThi0+dVWQnqOAVT92S2SHtSpAPdH/wBMOXwf
zK6246gkHp/Inyt13OASoltM+qSI8P5o0u2kaLPFZtyi437sNdIuUItyDvJDnbTI
ELz7zZYzOHz/dvvYv7B4QD5E9wA9AlKilQGf99ESgcLmEnYsM7RwKrag0jQRZ7d5
Nxbihq35CrPf5Hnnnhl2b850B/eJDh/ReEiS5rb74EwZ0S21LfKC
=HDvh
-----END PGP SIGNATURE-----

tag v51.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:11 2024 +0200

rdma-core-51.2:

Updates from version 51.1
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * bnxt_re/lib: Track and maintain CQ doorbell epoch during CQ resize
   * bnxt_re/lib: Avoid applications hang in resize cq operation
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * providers/mana: fix align_hw_size and improve get_wqe_size
   * bnxt_re/lib: Fix doorbell fifo register read
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * debian: Correct libhns library name in lintian override
   * providers/irdma: Do not override the raw op type in CQE
   * providers/irdma: Fix the number of CQEs attribute returned in create_ex CQ.
   * tests: Drop unintended t10dif flags
   * tests: Fix expected value after test_and_set atomic op
   * libhns: Add check for input param of hnsdv_query_device()
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1cQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZArYB/9056CxN19Nv+RCFNXK3UK/Q95Xdrn06Hwj
n+am85hzL26VgdPDB2t18uqLB3hMCQSYbPK4BQFTTmkhDe6oumjyGRczKpKG2m2T
FJ0P5/dDcC82hMTBKjdArQuIvQVqZjbPUZyHzCqdluxAfjXHMnWTsZjmKoQndn2g
vPGg23oh72o2B44CArOIYOb5QHwbeK/XBMkHMQ875DNZLoGESH8cJ9nj4Y/ghqJO
EKcbKxpmkQOy1pfWX7EHq14W+0cdFZivSDWrkjQqWz8+RC11FI0Q9PXfG+IEGIRG
G7GKUb3OE4pxwJnxcghoKyC6V+oZRGvpA6MauZGjAmQnT+Pt/Ydw
=HsPs
-----END PGP SIGNATURE-----

tag v52.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:11 2024 +0200

rdma-core-52.1:

Updates from version 52.0
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * bnxt_re/lib: Track and maintain CQ doorbell epoch during CQ resize
   * bnxt_re/lib: Avoid applications hang in resize cq operation
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * kernel-boot: Adjust rdma-load-modules@.service
   * suse: start rdma-load-modules@.service in initrd
   * redhat: start rdma-load-modules@.service in initrd
   * libhns: Fix no locking in the exception branch of wr start()
   * rsockets: Fix for cm_svc_run thread
   * providers/mana: fix align_hw_size and improve get_wqe_size
   * mlx5: Fail in create_cq if uar_page_index size is unsupported
   * bnxt_re/lib: Fix doorbell fifo register read
   * Added suffix libdrm to CMakeLists.txt for drm
   * mlx5: fix error message in mlx5 verbs
   * fix potential CQ deadlock in mlx5 provider
   * debian: Correct libhns library name in lintian override
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1cQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZEmIB/9gK89OG4I+WO9HWXOnRuLHTFowzSyZvUXg
RoybEC90lws6mHUTkQ1h1c2sGe2oPS2TOx1hV/IerIQcnnHhF+2I7JuEcDPLsd8q
F5BOFXOKgf2qmYgmELZvYrJh46fqhzz41QNqnzLoESyVrjrW7I1shOkYLsIMywGi
z+fA8cgLulWKlHh2jplGiHvMAKwsMkfrBkl5wcl7FtITL6A45ZMCttBz8ZGBb9Ts
fIC8bP+EmUPHmX7DF6viQ0YNOjoxNZCjC7xzGwzrTRr40XCSwD7pgC5GWATB6XNF
CuP75mi8FXlHhxSV1b/bSSCiK0dmCgGKKrjVfcAOfXkFUE3Gdt6o
=vqMY
-----END PGP SIGNATURE-----

tag v53.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Tue Oct 8 08:21:14 2024 +0200

rdma-core-53.1:

Updates from version 53.0
 * Backport fixes:
   * tests: Fix poll_cq_ex function
   * bnxt_re/lib: Populate vendor_err in the work completion
   * bnxt_re/lib: Track and maintain CQ doorbell epoch during CQ resize
   * bnxt_re/lib: Avoid applications hang in resize cq operation
   * mlx5: Fix mlx5_sig_err output for sig_type and domain
   * cxgb4: update t4_cqe_common pointer in c4iw_flush_hw_cq()
   * verbs: Use provider name when generating provider constructor
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFEBAABCAAuFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmcEz1oQHG5tb3JleUBz
dXNlLmNvbQAKCRCAG924JZiPZA80B/9TGGPkKq6nmlY83nsDPKxVVqueeXNx5gHJ
4p1nBQVqpef3vvk2x3OwiKdZR9L4RR7PDiUfSQr4H1/EoEP3qo3Bhi+UChYjyv//
jk4j0bJxXYSA9r38KGHpZ3bMES7vGaiBtODGAjv0tpGAVmlERsClN4UWWIyHxWNq
fWU93Vou+sXG53mLvha1qdvWyAuKKdcMRsKhNBNtsu2eBMTRH4ZPu9KFsTWOMXc6
bMAuydTUd6XESvhj/ryJW9Ki+4bEEYtvK8lrT3BNRCx/epi7tODb8Z9/V5/ImgD9
PaFxzyFVa9u1HLG4WvM0LPevJGPSy+fWLBPIdbaFNCnoWTIolrHJ
=YOcB
-----END PGP SIGNATURE-----


