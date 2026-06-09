Return-Path: <linux-rdma+bounces-22021-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aH0xFqAvKGoW/wIAu9opvQ
	(envelope-from <linux-rdma+bounces-22021-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 17:22:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5210F661AD5
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 17:22:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ldR2+xig;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22021-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22021-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB187314942F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915453F8EDB;
	Tue,  9 Jun 2026 14:54:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76403F8EBE
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 14:54:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016886; cv=none; b=UhqB+MW3GCWolR/Ac82UKwS0nguhOgQM310ax2MRqrZpOye7Q7mCSeTzW8LKPdl+FwV4ae6R+RstxNcGXzhvnuaLCYCzipQriK/mKd2TQqx5qjdPBRSyacDkc5Hfu+/EYRvH+We1LKIhq/0IdGOA97btCiK+oOldKUv78fSWMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016886; c=relaxed/simple;
	bh=qgv+wZWNK0Mz6GS1G2Fzoaat4uwNiLXjksBqYIHiD9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+HpBTDimeMzKlNYW60eIUiAvr6R6RA2BzHB8yq6Pma6C2NficWmXnBCEvV5PbqvmKC/izxZbkGZ8RAgt57D8BnEfyLWt3IVboFlu8w2mg5dehYcSh9b2wFBIe5cpkvX/xEOzpGS5B3gB6aKueu+m25DJFuTkumHSG96DkQgXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldR2+xig; arc=none smtp.client-ip=209.85.167.49
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa68e66128so5791679e87.2
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781016881; x=1781621681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvVZVpbZQ11FZGvsMbCfSWDPxvbVcumrUGTwFQKsLlw=;
        b=ldR2+xigwPJxfJ4NxPTy2V0Iouo7vJk5LJg1fLUww6Qn+hZR7eY10tYqvYae+1blmF
         UJkKDLmvVTdapqmurt5Hir+6Ef6Whh543baonrNbX6hM+XBT3irtEMiTK/uqJtqEkd9h
         fMC/RfCmhAfF4i1rm5qsk3odcEsJ466i0hrbV5NyQ9vIGPChpdoqYw8MIORj9MkvkGFt
         Dw6Zmd81Z7Yz6fa1EA8PkIMRZemfD2uXvaBEg2oxPWkS2Qkl26xWX8PPDN2bD2jrad/4
         czkDKJSpDyxkv9HO0eZxGcRXHA7AT9MbsDrlIW7Hgd3cl97OSWl0lQoeDluwkO6UGv5s
         MG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016881; x=1781621681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvVZVpbZQ11FZGvsMbCfSWDPxvbVcumrUGTwFQKsLlw=;
        b=h3CreRNiNVpmgadZU+s+kmNkf4a7PoI85FoPvPHNZDm1pGdZk70+wVzrLX2V8QzqaY
         B3YZq33Rmw/y8kKK9StLV++SWurDuge2l6U0emsL8OOcwX4W9txFq/WaFAjjUrX+P2DA
         AdfhF9urmiX0tiMIRhRJcuPDycDCYery7qAbF2QOAu+plPLIv9ePaSlT/q1s13n0cp/o
         c21G/uGVhmOaEzvToUH5k1U3Lswt3i+c7g5galonI36+x2leePtrII9iDQ8/2cbJo1sp
         encmhpNOUTd5dn9Usr5ED+99VCHs8q42czYeoQxK4s2rFidWWPP9Jsov6MttKbERusAy
         1J1A==
X-Forwarded-Encrypted: i=1; AFNElJ+BZbO2rHy5qFo9lovaEtalYxoaBw/qWSuGRmumM+xhRWMBZ4ueh5j+1bc2tIP9kDKe0gxcUowOziz/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxi4qPoTa9iYLMaHbaE6codU8Ul0vfDf5K4YIWAiX95nd7qCBN
	AsnqIpbv8A2vz/t7C4qUXeH/OQmKxnV5j/gZhI83VNyArHjR80nOx3DW
X-Gm-Gg: Acq92OFMXFbIpruASvXEAw+COu3ez4g5j9l6TiW+9kTMTuxRS62wPnPLSIuikWGCKlm
	MSY6hIjRTDzVqVEwv57Rs7waRg1gCkRRYmCAFwCW208/IKH9ZTO6FC13bOEuHVgbsutzSYHy0lc
	M1hRhmaIow+roqdNeAxNc7QtxdbHxmzhxcVkMJZ7XBb2h8yRFGYkmPrz2PzeTKaOnhas/TtC/q/
	MSfdjUnjhNS608A3p0P6suT8HovH5EfNc8TTHmWIPYbCqXKdkUeoy2NMcCUQ6eqeSG8+hrN660I
	XcmuReBtNxRKoFbGlAo+1jdMYIznw5Jr1uyYOczjhEz40zSD/WzT29mOtno7AwpAg56wVUzUf3S
	uLLvHE3wZABGbrXwwe5JtvhsL9JfO/jGEtywjA0alIPr/y3PSzzT+pInUTqImrWF/dH6g9OhAXR
	6CLmlq1miFB4Xurve48bXlwXpixPF5hmirlhyvCCnu4kDefi/Dg5//WCHxP8OuEu1Ir9G0
X-Received: by 2002:a05:6512:3503:b0:5aa:6c7c:65e8 with SMTP id 2adb3069b0e04-5aa87bdd028mr5627091e87.23.1781016880741;
        Tue, 09 Jun 2026 07:54:40 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed2d3sm4652172e87.5.2026.06.09.07.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:54:40 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Haggai Eran <haggaie@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: 
Date: Tue,  9 Jun 2026 17:54:31 +0300
Message-ID: <20260609145437.1837-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605-stable-reply-0021@kernel.org>
References: <20260605-stable-reply-0021@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	EMPTY_SUBJECT(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,redhat.com,ziepe.ca,mellanox.com,kernel.org,ispras.ru,linuxtesting.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22021-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:vlad102nikolaev@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:zyjzyj2000@gmail.com,m:dledford@redhat.com,m:jgg@ziepe.ca,m:haggaie@mellanox.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pchelkin@ispras.ru,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vlad102nikolaev@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5210F661AD5

Subject: Re: [PATCH v2 5.10/5.15] RDMA/rxe: Fix the error "trying to register
 non-static key in rxe_cleanup_task"

In-Reply-To: <20260605-stable-reply-0021@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

On Fri, Jun 05, 2026 at 03:37:28PM -0400, Sasha Levin wrote:
> I'm dropping this for now; it isn't right for either branch as submitted:
>
>  - 5.15.y: the bug doesn't exist there -- the task locks are already
>    spin_lock_init()'d on the QP-create error path.
>  - 5.10.y: mis-targeted -- it patches rxe_qp_do_cleanup(), but the 5.10
>    error-unwind path doesn't call rxe_cleanup_task() there.

Thanks for checking this.

I rechecked the 5.10.y and 5.15.y code paths, and I agree with your
assessment. This is not a correct backport for these branches.

Sorry for the noise.

