Return-Path: <linux-rdma+bounces-19953-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFBCAIgM+Wks4wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19953-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 23:15:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9384C3EF0
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 23:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F34DC3011BDE
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 21:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1C238166;
	Mon,  4 May 2026 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khNLVBj4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13323469E6
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929346; cv=none; b=qLg8qkXsWbyIalw+0gPMHvDapuA21iNbqSwYJAy/oltwtRq/Ix9rSwNzQhfuL2Zck8SufY7mn9J2cF9701Er71m0GlKxSqewAsC9aRG42cY09eh4efseKzdu4wc/jdCHHSKZ+m1HVf0fVO3aV71RXwoO6ZxXfTkk2zbzek/EK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929346; c=relaxed/simple;
	bh=DklPH6/6YJ0p6u4Cf1PUxpd4itLk/dZorR5WDOT5W/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbdAq/Z+O3O56VRwEvhM+2YxAqKIFm75P8b8SimsyMnnIuP/x1Yaz8w3GWZSvY1Y6pB2YtxV193qYIYoeFDGH7f4/78Ub5YsvMgyJJWQVTqtRkTP6JbbBVFq9Q4tm0QAcgsiZj+oZ8Rx9+eJAO6NtqOc2C8iEg7r/bVO7fCJuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khNLVBj4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso3496962b3a.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929343; x=1778534143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKpE5oRLemYbfg1MRy2f9zZjvjCWWH6F7jRfRxX1jLc=;
        b=khNLVBj4s5KuwBKGO9lJ/eqFzIsaK4KCG4wxZKNMPcAQ+Wn4tSOkIMa7+xeZfkE0IQ
         3wFfDaSM7aKJ7tAOwx6mOBeiBE8WMDL8FG64mRwSytpDDhYTVV9zxqzFnf4qocem4m1A
         Q4+h3WMazXtwwGvMdIgRuCns/ULO/NE5Mm3eZM+xBwLC9RJ/hmNkmXArWF+P2FqRgWpo
         kzPr/bJT6yDka0BgH8kQ15LdJqv5zEe13wipN0AXPaf3EYFO90kmSlHvuu2A7FxuV+TW
         qgI7HBYuOt+q9qGHJvR7VCt2OMa3CA41le3Fc1UEr9pkg1REKRRIeN+65f3hhLviS2Si
         tqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929343; x=1778534143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKpE5oRLemYbfg1MRy2f9zZjvjCWWH6F7jRfRxX1jLc=;
        b=buDztPtWODWDzumkR1iUZdaLLAXUHZfZ4VF5GDmufn7lRzY0CUtKO4CpDkPgum9NW2
         IfCKI21/Y1/fLgHvFa9LYCUml2rKi833iQe5Bvg5wLOFfNgcl21I1ndBPPh7QylggaI1
         yddfyJWHxH5KEO2EAtmcmvUcEl8nhR1+qjGLTcRdBl4wXJBaRiu+Dwm3I4qMPfAy0PjS
         P4MtC8X1PUKnkZT32x4XuN/vDf8D25T/agba25tijW4N2z0yopd0By8Ux5VguPQXUMY/
         ayJ58VK23Nz0PjLFir3kMUd30B6anmC3ZAR0e39ce5dFiSG06a3TPvNsjnZ3vuFa4y7V
         Jz/w==
X-Forwarded-Encrypted: i=1; AFNElJ++hnaQ+v/RMKnRZrHB4Y3vwjZFZbUKg6gW39s1AJu8F30lA5I9CLbWSO5w3S7/muyVm0vpN/VxHyvL@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAajGtYhzGGrNKWwK0quRsENMJjlxRGqZiRQnl7gYqPnxXAJw
	n9gpvRYgl+/oWMYLU2JAYV3REdAMKFclK4+XCoTtjyPHK3uJYVvVnqkAc2nckozNiQ==
X-Gm-Gg: AeBDievXBm+QRHFK62RPAIiXE0Vbfxp/46IJmvbJkgDjyHXNCwGtfN7WPMyy3Ncg/un
	3ql//sulS5IXIsa7DcDnPF1EEtYrstn+z3m1obT8NYABVujMZ620VEx2F3fRAyTxavRI0b8eQdy
	a2ZuH6knYWqAVbRXgUHD+Grti1ZWd7KZPy2//CgE+UJSTae5HsZvaFRjgAG8QkdfV7W2KZZGGVn
	0ho+ETsn5IwB3VJgv27OfpimZIuB5ZFfvOd57FLDZAKSy8EGgULNT1JrfuVrgZtZUJr+Qu0nTS7
	r1a5wPI96+t/n1IOIvMVTuBD6NrrNXQNPbHQPKOPH7ASvIWPGFIvslVjAuMwYcF5Agrf3AYnU5Q
	XyvE1h4w20BbnJldfIa2W4u/ZlKQgEdLkRAoHId9WdiCLIKd6XGvaS9BFRHsdDdrLzuQzX+Q58r
	ppWjZtOTbt70zt1N5OQ3FXWkI2MVp7ObU58BBb6bZj1F+y1mhEjS1z23Cap8apinWjOMhHGtxzZ
	MCrhQ==
X-Received: by 2002:a05:6a00:428c:b0:829:9a7b:db84 with SMTP id d2e1a72fcca58-8352d2f425bmr10106522b3a.49.1777929342450;
        Mon, 04 May 2026 14:15:42 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83943dde006sm41031b3a.10.2026.05.04.14.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:15:42 -0700 (PDT)
Date: Mon, 4 May 2026 21:15:38 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 08/11] vfio: selftests: Add dev_dbg
Message-ID: <afkMenQ_gfmLUJIy@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <8-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
X-Rspamd-Queue-Id: 3E9384C3EF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19953-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> Enable it with a #define DEBUG at the top of the file. Allows leaving
> behind debugging prints that are useful in case future changes are
> required.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../selftests/vfio/lib/include/libvfio/vfio_pci_device.h    | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index bb4525abd01a22..2d587b988c09fa 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -38,6 +38,12 @@ struct vfio_pci_device {
>  #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
>  #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
>  
> +#ifdef DEBUG
> +#define dev_dbg dev_info
> +#else
> +#define dev_dbg(_dev, _fmt, ...) do { } while (0)

Can you add something to make sure the format strings are still
validated by the compiler even if DEBUG is not defined? (since it
will almost never be defined). e.g.

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
index f4ebd122d9b6..406c430ef28d 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
@@ -51,4 +51,9 @@
        VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
 } while (0)

+ __attribute__((__format__(__printf__, 1, 2)))
+static inline void check_format_string(const char *fmt, ...)
+{
+}
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H */
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2d587b988c09..3abfa6ff481c 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -39,9 +39,9 @@ struct vfio_pci_device {
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)

 #ifdef DEBUG
-#define dev_dbg dev_info
+#define dev_dbg(_dev, _fmt, ...) dev_info
 #else
-#define dev_dbg(_dev, _fmt, ...) do { } while (0)
+#define dev_dbg(_dev, _fmt, ...) check_format_string(_fmt, ##__VA_ARGS__)
 #endif

 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);

