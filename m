Return-Path: <linux-rdma+bounces-18727-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMGjL0lPxmk2IgUAu9opvQ
	(envelope-from <linux-rdma+bounces-18727-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:35:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46393341C94
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E14B30620DF
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E8E3C1998;
	Fri, 27 Mar 2026 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gKHgKmlE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f229.google.com (mail-qt1-f229.google.com [209.85.160.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24623D3482
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603616; cv=none; b=DMbXP4KAGWbnnC2c5T/uUFaXK96KhgTgLmhDz3X9CseCcIUEo59L/RcfUXVVwv7O2HuR11ZWEo2K0Czyz5iyGeKnbgjpHUQLBJN8+WlmUNxdB1LaUvm+aryw9OqlhprrhckiEM1/5O3IU03Mx2fz1K89ZjYLJ86albhtqqw+s+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603616; c=relaxed/simple;
	bh=UkuBpeqHxhr9LqB+/HMPVdJ5S6rQRFUKODuMtQHmQNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXT62qaRV6qngJRxb+IWvLaZe+bHKFGAjNCmML44+wXQ9TFlx9NDPER5T450AqUulTwFuY/13vezi6JmDr7KwzMjmAvNs8U7AFS2AfzZwBgCOfPZYqqu14kYJHhn6IW6FXQCi6PbcJ5zvzadeXwxBjpZPYOAKcvAPa1AMVPdr3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gKHgKmlE; arc=none smtp.client-ip=209.85.160.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f229.google.com with SMTP id d75a77b69052e-50babbce85fso1324051cf.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603612; x=1775208412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvpLAeoDXmNz03WHRB0EatuqtW1TbwrM52SLJdDTuIk=;
        b=HJVGpJeVRPGJef/hJNjyTrDJ2Y02OyLNvPUz5Mob5uj4E1CMEX3CqF76tjtG/sSiNJ
         7RL87Q8pCNL13fQV1UUkZoQ6gmAVazkvLZeMSGjuQSvpsgb5UiPk9Zg3b5ZM8qzrixi1
         jA37s24ytGhPrDLb+ByKpRWagO6ZeHtzjqUMtY3lQenGXvA0v8QI/e6lSxBF50Ya7Qqa
         EgXeCFYk8Qx7sXGu/r7UcXW2vRAFdh4ilVAadbNxyg70oqadX6AVWal/e0bUOgO9x4Bh
         wG0dSya0orptRYa2XvIgmUutJTmUT/LWddajdgDsU2wpMUT5lOH2xCYPQPz8DugF4gyd
         pa3w==
X-Gm-Message-State: AOJu0YyG1rxvHQzOumpZVBo7fvFEnn+FORZkTdM4VsgFZJP0BDo9aHL9
	yPE/IDZQR/xrz0/2CNOfftNMOMtfIYYgC91kH0c7djpxUlBslSs7e6jtyfAxdWEl7h6Bvbb5rog
	YjMEIin0tl4T45jQWPH7QVd28jLiSkiVr6EyDtInsmSGik9nwNx2FAVON+57m2S7clTJHVzWrUa
	MluIFA2j76fFYFA2RWWUdkxCb/ZERJ3QBQIuSC1u+yUghj54axisGifjtQG7cE7VYQPljHdJig8
	aPKGDQb0idPap/MObWXCgF7lbGwqpc=
X-Gm-Gg: ATEYQzxtHkwfJ/xVwzS+6z+a7YGoFG0bQuYP0/apPCM++cySz5fa/AhYTQrx/mqDXbt
	fAHaTt0KXiDBET+FRK8VxUXHg+n4o1cd4xogbNvfACssKWAVh4Zp81V5vsXKdNaz3SfFeoz/SYh
	PdkDayCJpr6bTOitrMPPVZWuJagatl4WnkPH1FNhBpx8EdOn+vONlkWVWNKC1icOL/ebUW1zoPS
	XEZ9Mb5yhNDaalAZaUUJjZ+UPImi+DAjBqzfz+XEpHjLPoTrFUbiDlsqywUA+BcN/6Au82xPVj9
	zIjM5f9vHa1wfwH8QmlefiNF7bfbMRObc0hqmvclP5tJPqj/0DhFWqf7Lk+tPGWjPBSuKdBMewV
	FDjVDahAbivSK5osM59MUWr7bSkFspC7I/Vtd/TG/gAVROPyjcUrw8E6Uz1oQFjqJPomM+rYnx1
	+JiaIyQ88sovYgZRQHq5WlRRwKIgHw727H2Kfw6OibdIMDTH87+YwUpuZBs0HdwBTsCv75
X-Received: by 2002:a05:622a:345:b0:50b:286e:ae7c with SMTP id d75a77b69052e-50ba395ec1dmr22133131cf.65.1774603612346;
        Fri, 27 Mar 2026 02:26:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50b921540d3sm4357621cf.1.2026.03.27.02.26.52
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:26:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-79895ffb315so39831667b3.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774603611; x=1775208411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PvpLAeoDXmNz03WHRB0EatuqtW1TbwrM52SLJdDTuIk=;
        b=gKHgKmlE+kFVJPD0/1e1Z1dLpAeqFEFkyvnIyk+IcHBF/t46SZPWisNJuyawnOznAw
         dJ3/EsSogmVbUKthxOIokcC6bYHh2CpyGw8CVsag6oyOqGHdlHvE7dsSa36RVHaIuOAe
         EUcybacASPmn+lvmuAmEwdSqB8aVZN5/OsI5s=
X-Received: by 2002:a05:690c:e3ee:b0:79a:56bc:245e with SMTP id 00721157ae682-79bde060752mr13979287b3.47.1774603611633;
        Fri, 27 Mar 2026 02:26:51 -0700 (PDT)
X-Received: by 2002:a05:690c:e3ee:b0:79a:56bc:245e with SMTP id 00721157ae682-79bde060752mr13979057b3.47.1774603611146;
        Fri, 27 Mar 2026 02:26:51 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b17e4a0absm25718307b3.22.2026.03.27.02.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:26:50 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v2 0/8] RDMA/bnxt_re: Support QP uapi extensions
Date: Fri, 27 Mar 2026 14:47:47 +0530
Message-ID: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18727-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 46393341C94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patchset adds QP uapi extensions to the bnxt_re driver.
This is required by applications that need to manage some of the
RDMA HW resources directly and to implement the datapath in the
application.

This series supports application allocated memory for QPs.
The application takes into account SQ/RQ ring sizing constraints
(extra entries, rounding up etc) while allocating this memory.
The driver should avoid duplicating this logic while creating
these QPs.

The ring buffers provided by the application are pinned by the
uverbs layer before they are passed (as ib_umem) to the driver.
The uverbs changes are in review (see Changes below).

uAPI changes in this series:
- Patch#5: new uapi parameter 'sq_npsn' in bnxt_re_qp_req.
- Patch#7: new driver specific attribute 'DBR_HANDLE' for doorbell region.
- Patch#8: new comp_mask 'APP_ALLOCATED_QP_ENABLE' in bnxt_re_qp_req.

Patch#1 Refactor bnxt_re_init_user_qp()
Patch#2 Update rq depth for app allocated QPs
Patch#3 Update sq depth for app allocated QPs
Patch#4 Update umem for app allocated QPs
Patch#5 Update msn table size for app allocated QPs
Patch#6 Update hwq depth for app allocated QPs
Patch#7 Support doorbells for app allocated QPs
Patch#8 Enable app allocated QPs 

Thanks,
-Harsha

******

Changes:

v2:
- Rebased to umem_list uverbs patch series:
  https://patchwork.kernel.org/project/linux-rdma/cover/20260325150048.168341-1-jiri@resnulli.us/
- Deleted Patch#9; create_qp_umem devop is not supported.

v1: https://lore.kernel.org/linux-rdma/20260320135437.48716-1-sriharsha.basavapatna@broadcom.com/

******

Sriharsha Basavapatna (8):
  RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
  RDMA/bnxt_re: Update rq depth for app allocated QPs
  RDMA/bnxt_re: Update sq depth for app allocated QPs
  RDMA/bnxt_re: Update umem for app allocated QPs
  RDMA/bnxt_re: Update msn table size for app allocated QPs
  RDMA/bnxt_re: Update hwq depth for app allocated QPs
  RDMA/bnxt_re: Support doorbells for app allocated QPs
  RDMA/bnxt_re: Enable app allocated QPs

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 292 ++++++++++++++---------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     |  18 ++
 include/uapi/rdma/bnxt_re-abi.h          |   6 +
 4 files changed, 210 insertions(+), 107 deletions(-)

-- 
2.51.2.636.ga99f379adf


