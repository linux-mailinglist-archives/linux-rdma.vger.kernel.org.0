Return-Path: <linux-rdma+bounces-19200-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKFFO1JN2Gk/bggAu9opvQ
	(envelope-from <linux-rdma+bounces-19200-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 03:07:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B163D0F88
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 03:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F0D83013A82
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 01:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD5D30F7FB;
	Fri, 10 Apr 2026 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4/f9r80"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62624466C
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783244; cv=none; b=EuidfXEJxaVD8VVLBErUVzDEmx8NWyY444ksC16vHR7eQGBzb+Rgw0OC7V+ubs77KP5wxXelgkQTmgNjNGCqeR2RgkMmKgcq1vwLjdUbwUk12e/dFjnLTYnHxltdh0fLHUaYH9KVPS9s4jbegbM6vMj0DetHhMEc1HqicQ/dYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783244; c=relaxed/simple;
	bh=+XU0Cnc0F0LjxGhCq7YCeZ8ecdZAWbM862WFRJOW89Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkb0RY9+EiixGH21DbPr1OqXIrbhVRPukXMfnYKUE2rXmro340dngE3hWDHJxysnb8iMSut1j1Sbo7l7wua2FBR0nJpbQJuNciK3JrPrWyS14pPPPN4qeq1npitl4JIr8qIJnEvOAmLELeKD+3WpVCaBEhGEFivt0JbalpL/O/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4/f9r80; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf906b007so895689f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Apr 2026 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783242; x=1776388042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlkLKvPawGtjDmpjAZR4K55fjs9B8OmYHw7Fk7oXyLI=;
        b=r4/f9r80WYeUHAtZe0OL6q+T6cTZ49v3Mt5y8M8SI0LXZ9TOXWRSjgDJn9fC7Om3hu
         xaFJm4CxnLcNiTsXYlKghCnaZzVmt69L1Vt0NbFZE5bUKPA101RjCrgzOVylfbvOHl2a
         3oPHc4D+gYju/nri20m6cuvxSWawJj0Gs25mWzMW1jWo+qFU0pa0rEC2aBHR93gQAh08
         JV+5BYHn54yKA7N8oCqjP1WvrKOyo+Bd4nloSTkzCd6KCdpEUz4qSzS7qyE6EtIt6mcW
         8S6jtK7NOyKDc/mrwsKDKA97apbhTF30pRlM2nxh1Wx8IgVlkQPFV3W2RPuuiE78SQBF
         1prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783242; x=1776388042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xlkLKvPawGtjDmpjAZR4K55fjs9B8OmYHw7Fk7oXyLI=;
        b=J8JSYK0oAM+LQ3AhXJRiKIL8J3YK2+qym+5twbZzkmtM2yEIdXx8pOOm0tHYSJ98yS
         4hVmYPYH+3MCEpRx5dTtZ6dUdfzPEbj2LaVPO9F2bqPuYJkLqe2idl0g7dAhNL49JEEx
         TO+RU511IRU+zgwHlQvE2e8BM5Lu7T5M4HHKlTg5demnUhWC51AXLBoqmv/eexPPNRa0
         FpJ7zsnQ578uWFPNzmpIIuu+HrZtIqqVBSlCrVIM10NzgsYd8gOxJGvozuX7fHRIm67c
         NFLD2JCq6C/3T4libDu4Nr9kpptminsUcrcbY3+dff09QW17sIEZf4VNr8GRuPQiAHaT
         h6+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXehogXNr8KdWhbWxyfqzO4/qmNe6voPuqYZSiyHiczVsY+IkQL96QIUsHmPweHQ/7RC3lRGIxuFsy5@vger.kernel.org
X-Gm-Message-State: AOJu0YwsY/OSBbExAR0SLvhze0YUCytmURqy0kuH9KodljM5U81+LMJt
	n7b8RQxj1iYHDkVRludx827J2dhgzoC9b88lOjrBwhgx+z0nO37oovjM
X-Gm-Gg: AeBDiestnmq4lIEsqdRXuHMqgKytvtsVP+tKxtLwpae0HzHmztmNOVHkCSCBZMY/UeW
	SwbsGAdhMhVRDXS1i/WCLAS0bZeuxR764pW0nWHVsVw4ifn3wV2VYmnJ2PACOhWiEFyvVD5Y8bP
	rkBmc+USkBZeuyN/mjo/2jsr3KD5+1WuisZ++Jgvl+nyT20EbnqJtyn1Omb0XMe5fyoxV5Dd4O/
	zI/AOrxJ47Ni3O8jc2DGRUpMKz8XfxJ04zOiWnLhKdztySGD05/Yz046f1ZSzA907xNa3Im/FEz
	UYlKqx3yBjy6wLdZ2C7Cti4Hsj6XIWhayeDkDNIP/LF6d53pWEAWcEeYlFU+JRGZjOMCtO+9Egh
	HlwaBZMMsADE05Nutceyn0h4ZGSmTXNiaKbvHRFZQiMdrmB7erfF/x6FE8m49clWtonxfdyqJnG
	NJbyGWJj9XziPDK1wcTdTQ3pVUVwm2QcESnaurW7iMDENivcwDVcfua1E8r7EeDBRPXFx9+KtL7
	h882tduCobN13hNbMffVyFAxE7gxnUnhpChmRvRCWb/rYRQZ6xcDjWUlDk=
X-Received: by 2002:a5d:64c6:0:b0:43b:4aba:8f35 with SMTP id ffacd0b85a97d-43d6427a2d0mr1520761f8f.12.1775783241750;
        Thu, 09 Apr 2026 18:07:21 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a48sm3485108f8f.7.2026.04.09.18.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:07:21 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Fix potential NULL dereference in query_device
Date: Fri, 10 Apr 2026 02:07:06 +0100
Message-ID: <20260410010719.5300-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409095158.GE86584@unreal>
References: <20260409095158.GE86584@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19200-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 59B163D0F88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 12:51:58 +0300, Leon Romanovsky wrote:
> uhw is not guaranteed to be non-NULL in mlx5_ib_query_device(). This
> function is used in both kernel and user-space paths. The only condition
> that cannot occur is a caller providing a non-zero 'uhw_outlen' while
> passing a NULL 'uhw' pointer.

Hi Leon,

Thanks for the explanation. Since uhw_outlen effectively guards uhw 
in these paths, I’ll drop this patch as a static analysis false positive.

Thanks,
Prathamesh

