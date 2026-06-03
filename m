Return-Path: <linux-rdma+bounces-21680-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hygAIxkiIGprwgAAu9opvQ
	(envelope-from <linux-rdma+bounces-21680-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 14:46:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92072637AAD
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 14:46:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=f63Jgjq1;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21680-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21680-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2876130225D5
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 12:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9888244CF29;
	Wed,  3 Jun 2026 12:42:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F520FA81
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 12:42:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490554; cv=none; b=C3s4k2c7sXe0m/d8cCWEuuUlbyvn9VUyrtMhVbGS9bvTBPTkstWQ/nRPMJ7FtA1bprlvs48aMnmks6vZOnTkiwg80lOm4J5VQhzshsY60RUIOPkbJsHdqV4xKzaLgvzyE3us1Ipg6TY4yh+1uNH/7aA05fVcsMbcPWRKJoZWneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490554; c=relaxed/simple;
	bh=W45UheOnEo6xoVkJQ1bKfCsHdmCm5iK51xyJNLoBVoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMdk3wo9Uc5ZhokpZVSRqBcDgjaLg7w/FCfVphsC1oLWK6oRlBNCLZWBIrXl8cPCZn+RugpSk/VZ1HKJ+j4dJc6ajDbzBQHiwgkvmvfdp+6Pg5+IGmLjXmxW9M56DwZuBVDS4iR00jYK0Z2v1lWDOunzvu/wHkRCAhvFKq5RIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f63Jgjq1; arc=none smtp.client-ip=209.85.208.178
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39677aed4d3so33751801fa.2
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2026 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780490551; x=1781095351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDtZiNqgwPDv3Sul4nimrZPm2bZQA1f3gdfMwdog6fo=;
        b=f63Jgjq1hbiRXPvkB56dsXESilnieQ7md0DtpAgkc1fPyO0cdPaYlm89o3EzH0RGub
         e6O2W+mgQuPLCjSzFN7rsOh2iQJfYeU31w+FhmQuomXg8J0ZJeiH3PH83QUI+eWOSktm
         VldorI6NtUm6NYcIAbcpHOAP8QbnNx5+zb7APqpH32gTrcVfs/1pX7b3N672ThWxocbX
         VvI/TchUhFe9gqhZcCtXM3zNZmZXatF80Iqyi7pXIlNpSwfzTs+JzYs66M8zhntZFyFB
         gCdFcTh3EOImLfTRKjL0IaLX3eYHPxf5yqegkORgqE74nGMOk53cMdfqtqWuhO0PXZnv
         PyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780490551; x=1781095351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDtZiNqgwPDv3Sul4nimrZPm2bZQA1f3gdfMwdog6fo=;
        b=m78vrCBKhn4NghS4dvS549a7Xnkix37h918/p7sp1wUBqmzcAqw15wrSru7A8JbCU8
         uc+Iwq3ahwV2DEZgO+OxtNUMMKtXCPekR1x9SZoaGcVyfJrC+88Hne+4jyAbtaUUB+80
         sJ64YTqGcPOky4dJK+CfTdFSplwicHXl3Az3LwqFoOEdV64M/Yszr9InXunQyI9OYQVj
         +kA7XmvybXntlOM2EUPpHBJN0GbDVY5sefy1p2P6xjXIxBwr8Gfa0osV9jgZkQsXv+B3
         2THLt9i9MolDSX9+wjXAv9dg/N47AHNCCJwrXUf56AwgqYlFpP7b60aZ3JKRSb3uiQcR
         N/XQ==
X-Forwarded-Encrypted: i=1; AFNElJ98Jqkg5YLMGvhUpoBFQWkiVtBiv63WElKB4zzvSdB4y8tD67D6p4O48JSJUhBW09x3be67CykVpUeq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+E0NekgHKC38ptl4QtI//WqxOBU8ZbK5PGbgPAc4i61kx0LpK
	KcIGK09eYT6PBN5FsC54cPeWcEGGJ6++vE5YeRkGChzlDLPy4EMpE/+w
X-Gm-Gg: Acq92OHPP3JI0tnSqMIZnTMqoxCwabI6Gh8M76HgwRrLI+DRpq6cRozn79tieR6gYtu
	ua+5vfw0B/llwdqGdYcSzuvqhgV3FZi1MXK/UBQcHQCwZSMCKGsTRLX1/hv6bZIfkgpPV0wvsz8
	V2okiyfvMg1GWwdVTPniAYGW+IhFHQFgjdYjmjZGTs+JNgNcfCdUPyp6LF0ix5AchA+1cwE5E85
	ItonrPmgulitKYJU2q2XShtbDDXpHefB5fQLGW80avMFaCGMBjeagUC1Vf5ahyrse4tle4xk4bN
	r6FEJVpzy6b9vUULSj2b7ir7f5GGtERLdlx6ityoxXJvUEuRBViLYkusdbdbxR0dGbcGgDAyjbC
	kDnYyHmZKnmk7tGnz1KYchEaauHTp9rUEVkhPaRSFNLHMsnKO64LV4WwdmM8oiloySUBXQavq7Q
	J8SoyEtDxJQQ70j3FstKLVLI/0/QS1OcTnoJ5VDzrSauTFd6TGYn2oN8f2mAoFe5WEacOF
X-Received: by 2002:a05:6512:33c5:b0:5aa:6d0f:1dd3 with SMTP id 2adb3069b0e04-5aa7c0feb53mr1122592e87.20.1780490551272;
        Wed, 03 Jun 2026 05:42:31 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ac3fsm631197e87.42.2026.06.03.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:42:30 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Kamal Heib <kamalh@mellanox.com>,
	Amir Vadai <amirv@mellanox.com>,
	Moni Shoua <monis@mellanox.com>,
	Yonatan Cohen <yonatanc@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Yanjun <yanjunz@nvidia.com>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10/5.15] RDMA/rxe: Fix the error "trying to register non-static key in rxe_cleanup_task"
Date: Wed,  3 Jun 2026 15:42:24 +0300
Message-ID: <20260603124226.296-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601165404-4e37c4ba7b9a60b739186cc0-pchelkin@ispras>
References: <20260601165404-4e37c4ba7b9a60b739186cc0-pchelkin@ispras>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,redhat.com,ziepe.ca,mellanox.com,kernel.org,nvidia.com,linuxtesting.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21680-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pchelkin@ispras.ru,m:vlad102nikolaev@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:kamalh@mellanox.com,m:amirv@mellanox.com,m:monis@mellanox.com,m:yonatanc@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yanjunz@nvidia.com,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92072637AAD

On Mon, 1 Jun 2026 at 06:59:11 -0700, Fedor Pchelkin wrote:
> There is another
>
>     rxe_cleanup_task(&qp->resp.task);
>
> call at the start of rxe_qp_destroy() in 5.10/5.15 kernels.  Should that
> be taken into account as well, like in upstream commit?

Thanks for the review. Yes, you are right. I have sent v2 which takes
the responder task cleanup into account by matching the upstream cleanup
order and adding the missing qp->resp.task.func check.

