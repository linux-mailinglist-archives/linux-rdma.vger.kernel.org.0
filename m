Return-Path: <linux-rdma+bounces-19206-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PlvOszO2GngiQgAu9opvQ
	(envelope-from <linux-rdma+bounces-19206-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 12:19:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 554003D5928
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 216153041A65
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 10:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4D9381B16;
	Fri, 10 Apr 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO4LZCPr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9A937D13B
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815946; cv=none; b=OljxWohH5asQ0tq3bDiq7D9RqQHhEaoPNlwXUBLVqQNuwgp8lZBajFkLA5ngTokZD2JXcG0uk380f8v45gPPs4An3iobe3Q4MnvvILcGz6iYBuydOL4fGDG+xmKwRBx5sJXmV3AmiG8dmuU6XHz8SODcNHteiXW7BdczELSDKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815946; c=relaxed/simple;
	bh=UzBfB584tIHPda3do0qGmryVKOb3AsOxBFjS2GjrQ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BdILE3xqSKIRLbLUCDPSuH1BF1KW+NrAHFTjkctJgD4OOWP/Hae0DjqLP2vYs5trxRRjDvENLy0BaP6j7ll7d9RwtUdpcw+RjsLbZP5iAl0bpQa38mso11k0qFDO98waxiZxeMEDWv+N+HeZN8f27LcdO9bhwif30lcsZNnFxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO4LZCPr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d5ec211abso965689f8f.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815943; x=1776420743; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlDiNOvkU8AjRLJcF8pWCYuckD/DjfS6AtfPY3AoT5M=;
        b=SO4LZCPr6NdSUMO8yDIHmzeVOhTDmGiZQdbLI8+reJZKN3+4ewn7uw33n30hNmpf0b
         33ZKDdPr0fzs2VNTqmlnwy/YxlpPdPAbABoIyGEHP7a1U3ZKQ0uJxtgNeWfCC4KFZrlx
         NNGV+EX5fMcB2zVu9oukx9r83SzLnPaGYbvkhqdrBTY5UYbyah2IdnshJv/A36iO0O0T
         2O3Fj35guXGa9cQcJ8GmslhRcFG3DTh5BTF/uFh4tzydNtMaS+WwQe+e3EndicsCO+HM
         7EOYTBe7dTgyiKSN4t7nORmbTpwhy+bisga8nxqqPbvhg9X9JzeldP7NNocETiKPMFEX
         vclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815943; x=1776420743;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlDiNOvkU8AjRLJcF8pWCYuckD/DjfS6AtfPY3AoT5M=;
        b=p/HFNrSu8JBAZ+fQZYLB8CCe7ukbTtqNHc3aFQFnpYODAYzRVbvE8nFi9fmChNAdyq
         UGDYNmZKmDscGtubP/oifpABgQjfUZJt2LLLWuBPCGk/uJ8ufDxtDiaTNPE81EFs8Faw
         Vjm4ztMZ/ZCQ/6fwM4M9as/nTrX7wd9PiwWI98L8l5VBNNReLhxQuWLvNd51glAHgypa
         gXWm4X2/VICHCgwSvuPQ4x+/AKKtP3P0avN4nL9z1sPlMlvPgNlC4M5NYHU+tI6cpLRs
         GbKPVxTJfcOR4x1tIoqiQvfQ+Krd9Pj1zXWxVSjDu5oqeGt8PwRCHSBDBSGEGVeAP5Sc
         ByyQ==
X-Gm-Message-State: AOJu0YwCoTEycp2YYkjGGUtpXORlEAt0Oy1r6zsJJf3srneePu2SoVb0
	zUOrz2Sxtfrsc33CkG+xf8o36GTDddJiNz2Phg+L980bDmAx0t4KRodU
X-Gm-Gg: AeBDiesTxlK+Dmq1hoMdK33EJGrrT1sZfCDhBEa+OH+tP7JAHda06yZ0yZbvpWncqe7
	EHLg96WIoe2InfP9lx74PYDQzMRcYg1ZzKkdQL9BbukAV1/Hp++8GGoQKaMM0Z7j9nbSTqJnbyV
	BsEjojoD4QMgpIdFJkjCCrXYeUsp8dTsKAzWoOsD2z3Jsext36w8D0g9xjrh9th07hpRO1Dx+r/
	i22BX1xEJYskCB/N5zIpUl6QZ8hVgNqpt+hhPFSTbOyi4O25zLWiAq+efTCiJCmThoCJhCwe5P+
	zdlQdmBsqmE9ntiR38wiEBAw41WZNj+D2qu0lokVCcUeeDS1MfpaPH8+PW2EDodjgCIcZbsX2ES
	d+EF3wOR77zeoONO4SWgf7SLj6xJfJTpwNVlJ+1rWG97Kp3hE0n7+DlKpEMcDflJ9K2fYq63NHf
	eohL22hkUoyratu7lYGkM=
X-Received: by 2002:a05:6000:4026:b0:43d:dd:8cae with SMTP id ffacd0b85a97d-43d642ae60cmr3612750f8f.22.1775815942989;
        Fri, 10 Apr 2026 03:12:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e468c5sm6646229f8f.20.2026.04.10.03.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:12:22 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:12:19 +0300
From: Dan Carpenter <error27@gmail.com>
To: Michael Guralnik <michaelgur@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/mlx5: Switch from MR cache to FRMR pools
Message-ID: <adjNA5vyWip-LtRM@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19206-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 554003D5928
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Michael Guralnik,

Commit 36680ef7bceb ("RDMA/mlx5: Switch from MR cache to FRMR pools")
from Feb 26, 2026 (linux-next), leads to the following Smatch static
checker warning:

	drivers/infiniband/hw/mlx5/mr.c:299 mlx5r_create_mkeys()
	warn: why is zero skipped 'i'

drivers/infiniband/hw/mlx5/mr.c
    289         for (i = 0; i < count; i++) {
    290                 assign_mkey_variant(dev, handles + i, in);
    291                 err = mlx5_core_create_mkey(dev->mdev, handles + i, in, inlen);
    292                 if (err)
    293                         goto free_in;
    294         }
    295 free_in:
    296         kfree(in);
    297         if (err)
    298                 for (; i > 0; i--)
                               ^^^^^
This should be >= 0 or we leak the first array element.

--> 299                         mlx5_core_destroy_mkey(dev->mdev, handles[i]);
    300         return err;
    301 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

