Return-Path: <linux-rdma+bounces-21470-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNerIQnDGGp4nAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21470-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 00:34:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC42E5FB07C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 00:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAA0E3060C80
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C22367F36;
	Thu, 28 May 2026 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTusoSH/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935636BCC9
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007416; cv=none; b=CFC3JxfeaMZhn4VwVJPDwZRdErwbRFS7Sh64h4Ug7MTT/jJJp7rQ/WPS9JvBs+dl8gZ3kzjEGpgEjq0cGF8a/cHFBXqnz+BDs467+Rb7qNBvY4IWCYFBHXh5wIw1RDUpKK/is4DHbYFd62w18gVtLOdHGJoG3M0HsaOUGAOXpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007416; c=relaxed/simple;
	bh=XE2Nz8XY3jfeATNv6GLApHENG4QyQDJPsi8VaxfTPGU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XPFrRTQojItVtth0GQUmWSg5yctvDKh5rDfRfDaAkGK5VcsLtTq7RipmVbg733Etuan+WMQLcrpGCEkJ2J0jaIALkCOn75EbCX2PcnqXOdIeBTSStIR+qwxtoZUQ2NkipjeaNfcF0Cisry37zQhWtCBTX8Eu0OWK+9ZCfIK4lBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTusoSH/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bcda7765d64so2489598166b.1
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 15:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780007414; x=1780612214; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IiJpfn9/OPGvc7lLpZ8Q6/8VjpgeaL3UxQCz6z34DRA=;
        b=fTusoSH/yR8iRjMuEGolfK9IdvTG98QnfWNc5ntZmmtvFNYpX+XZ3Zt8Z8RuEHKgY5
         pgurGfE59frtj1mn3DMs2GYMIHnrIW5eAuETCT+Zw8vzB3I+jUX/TAt1NwK2AdkHzg3D
         nrKx9G3+JKcXt1VEthRd2X21kk3tHZLruFchaYF5HWU8EC9mdD++jQI3TJaXUfw/4D1Y
         GjJtSJ5G/3w4eFGmObcsjd09fNw/ZSf6mngyWIeix4ZZlzi1df0w8TMexlXXxx7i65Yy
         6+KLzuUxiRBRwon1I3880/LRzoxghuKIAwxUwENexKS5aXtKDQPyuvAXBrv6GlfcPGIZ
         PRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780007414; x=1780612214;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiJpfn9/OPGvc7lLpZ8Q6/8VjpgeaL3UxQCz6z34DRA=;
        b=YnURBew8rWE5HXmN8dJeXkOlpRV8Bl7BzvXsGG/37LFa9VeFj8PKO3dpyuz99WuMeJ
         hmP32gSNGNBkvrwpgShFjHmkcEz4kQoF02W4iNx0sUG3VcMVEV7bxop6Pa7xv0CHgT7R
         WYdB+0rSD3kSWHxEjQcqDGD69xY7xN0pI79dsUngTE4sb3lKjGCUNGJm4xA+0viB183j
         Wb8FDUKc1tC2uvdhXluQnUZikPrfQjoCSG+68c4tklydU3/JyESnAWnao4ZVk9oVSEim
         qhnw3ShjQIDLfl0ANuyNCwic4faveQs/JKprGNPiOY3NXiRkl3JNZ1puZvEmMWRRPvjR
         pUkw==
X-Gm-Message-State: AOJu0YztOJT9lszkVYsgHqzs7vZXIoRTl+YhX6YC0RQ+VgeK5DkSumjr
	jCc64EZY/mbMl9IYpU0II8vyXYxiJQ58mPS7IB8xorGh2baa+Eaw4VdWu2uWgVhL
X-Gm-Gg: Acq92OHCRf98Pj2rXx+pTANpMQ55bTW3eqM75/lQYmLmLpt4j6eTSE99TfAhiogKz+1
	hq+RVVrhkreehsmcqQRz15m90rZOsnjyMCoNC6y18ndGc1uzc/woxomx/iRk9/4TYR1gDtz5NlH
	VPDD5Gi4P8g2o+RPZVF2z+D1k0/tb/zH3KPbnTu/s3Zs8QODHnx8yMUAq+8P/bOr2ULqvshLkSQ
	i3tbgr7+Ye32tG93byt9B1cWNNh02Ie8m+LS7GKs4M0nXafNvuHeF7WUKx9wB0+QgUu4kJobm+w
	M8rjpNfWZIUBCU1SwYKShqv/orMdwz44qess3PL3Y9pFukcQQHNVBPLnPovRbJBsSvG/gFhnlZ8
	b7S4LX7qxQw2XU949hrO/9FtgmyMMD9ODYPPR++16b5W97IGVBkv3YL7YCcHKzF6johx+cxSya+
	sOFtI+wJN4ycjg5xM7QTiRLMW7tcZ1yRpAM4U=
X-Received: by 2002:a17:907:75e4:b0:bc5:2352:555c with SMTP id a640c23a62f3a-be9ac78d0b2mr11752866b.14.1780007413511;
        Thu, 28 May 2026 15:30:13 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be9b2bc9b50sm6105166b.0.2026.05.28.15.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:30:13 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 977B85A0061; Fri, 29 May 2026 01:30:11 +0300 (MSK)
Date: Fri, 29 May 2026 01:30:11 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] RDMA/irdma: Fix typo in SQ completions generation
Message-ID: <ahjB87k54bYdFbft@grain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21470-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DC42E5FB07C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When we generate completion for SQ the opcode while being properly read
from ring buffer is ignored when written back to completion. Seems
to be a simple typo.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
Hopefully I didn't miss something obvious here, found it while been
fighting with unrelated issue.

 drivers/infiniband/hw/irdma/utils.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-tip.git/drivers/infiniband/hw/irdma/utils.c
===================================================================
--- linux-tip.git.orig/drivers/infiniband/hw/irdma/utils.c
+++ linux-tip.git/drivers/infiniband/hw/irdma/utils.c
@@ -2442,7 +2442,7 @@ void irdma_generate_flush_completions(st
 			cmpl->cpi.wr_id = qp->sq_wrtrk_array[wqe_idx].wrid;
 			sw_wqe = qp->sq_base[wqe_idx].elem;
 			get_64bit_val(sw_wqe, 24, &wqe_qword);
-			cmpl->cpi.op_type = (u8)FIELD_GET(IRDMAQPSQ_OPCODE, IRDMAQPSQ_OPCODE);
+			cmpl->cpi.op_type = (u8)FIELD_GET(IRDMAQPSQ_OPCODE, wqe_qword);
 			cmpl->cpi.q_type = IRDMA_CQE_QTYPE_SQ;
 			/* remove the SQ WR by moving SQ tail*/
 			IRDMA_RING_SET_TAIL(*sq_ring,

