Return-Path: <linux-rdma+bounces-17550-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF3uJ2y5qWlEDAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17550-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:12:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E2C215EC0
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D089A31AA098
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 17:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A809719DF62;
	Thu,  5 Mar 2026 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xu5hJORF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6993D2FF4
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730512; cv=none; b=Wh+8uPPEfzYPErIwwQ+gQVbfLtdSX7lJekj3/KQWv5y8uOUFOcOBpL4JwElcxVB3Or0EjdgRid7oNyhi7osjXSrRPJBdL8jTSFyhqHvFxAJ4h9N9geX02kyoFtKIEXIq8/QcR+bcR4L/ofekajRxK2+hvoZLD8s81WvF4rv/5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730512; c=relaxed/simple;
	bh=E3TPbJfCZepDA/7vq0CKXyCpFEyU02ViwvkhJ1R9Ffw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b/nAvQLZqYMEPQ8WPIMuMmG/95SMTQ86Wzyt47jZQd9fwjb21nRTikI8BvdxZuGh0Kgh0S5In1/8029+QUoadKROi6oPc7/kws7qPupBKNwOEqNGahDKTViVTeoJEW7gMl03Ycs/BNg1ROIQRd8RK7VoSveTnDyI9SlgYR5yOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xu5hJORF; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb5359e9d3so5144280785a.2
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730510; x=1773335310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6bf6Now1v6wt/FYiYrWiSYg+A+5NLeXqehxAnNtMNtg=;
        b=xu5hJORFKB+1WHYOKd0guaftOcn9f/tHfQQwe5pygN/JBnNJ/nFNQXAzYaEf+zbfys
         P60CqJYGKI4x4m08CyEELeo+chWbQ8/YJPlJSoCmW16GiiACdPghJw37DEuNeknWB/F3
         4zvEMITPAOlm6Vqe1B91ALkvvixxjxvcQ4UTtV4tKryTtujA8Fq5qWdLetJ70OB1Gnna
         rQgx8xRg7nG/P+5cugOL+qGEisSaZXM72AXdyExlZcPKBxVM3GfEzSc5U/Xl80b0sAso
         v4Ic4TMECpwOWGa3QLWbBT6sKdDQ7LZQ2eRe5oW/X/f3fsaM+HviU+uq3rlS0INcjZMQ
         ZmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730510; x=1773335310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bf6Now1v6wt/FYiYrWiSYg+A+5NLeXqehxAnNtMNtg=;
        b=JwDZKTcqGvjM5ap+7Zq+ORb8YT3sDH6UCJd2ld7f+m13XTJvpvJANrxnwotGFzIypF
         AxYb8HV5xo7WIOEvoyNkbK2LLnPnFaR/s8LO8g/inRz+n7qxMFcNJ8R6NmfiBlfpzYbR
         qUxFWPQ9YyeSYhGSrIhB3+lhLxDjLOwBya0J+rc2umHheYv0SrbNSy+L1fjt8mweVtXC
         PW2WMz/sYpew8oDaiNVDqpC2HJV4MkX+P5bVaApZfa8uBpziefADe/pYn9KjANK2ZiH7
         ZnHK1RamEb3BhD5B4J+obkWMhXTpu84fU0hb2deuDd2+eDwbFXRUAhH1NIN7bwlI9+nG
         D8vw==
X-Gm-Message-State: AOJu0Yz0jAp9BdX8Bk1wqcbMlWteR2+h0p8O469kGzdCLku5DnH+wX3a
	fBDR7QbjXPSZTDLtVFXvvvxlCW31QxIpAt7vZQNX6hgCBUq3U86cYma+YhsXuaFCwV6vcu0ZXFV
	sYUsZeHsX+Q==
X-Received: from qknsm6.prod.google.com ([2002:a05:620a:9446:b0:8cb:3ce4:1229])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4723:b0:8c7:1afd:a535
 with SMTP id af79cd13be357-8cd6af74173mr81130185a.25.1772730509941; Thu, 05
 Mar 2026 09:08:29 -0800 (PST)
Date: Thu,  5 Mar 2026 17:08:21 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305170826.3803155-1-jmoroni@google.com>
Subject: [PATCH rdma-next v3 0/5] Add pinned revocable dmabuf import interface
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 08E2C215EC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17550-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Some dmabuf exporters (VFIO) will require that pinned importers support
revocation. In order to support this for non-ODP drivers/devices, a new
interface is required. This new interface implements a two step process
where the driver will perform a sequence like:

    ib_umem_dmabuf_get_pinned_revocable_and_lock()
    
        ... Driver MR allocation/initialization/registration/etc
        
    ib_umem_dmabuf_set_revoke_locked()
    ib_umem_dmabuf_revoke_unlock()
    
This allows the driver to provide a callback that can be used to
perform the actual invalidation in a way that is safe against races
from concurrent revocations during initialization.

The driver must ensure that the HW will no longer access the region
before the revoke callback returns. For MRs, this can be achieved
by using the rereg capability to set the region length to 0, or
perhaps by moving the region to a new quarantine PD. For HW that
allows the driver to manage the keys (like irdma), this can be
achieved by deregistering the region in HW but not freeing the key
until the region is truly deregistered via ibv_dereg_mr.

Changes in v3:
* Removed separate umem_dmabuf->pinned_revoke_priv field and used the
  existing private field instead.

Changes in v2:
* Created helpers for acquiring/releasing the umem_dmabuf revoke lock.
* Fixed rereg_user_mr handling in irdma to account for async revoke
  and used new revoke lock/unlock helper to simplify the dereg_mr path.
* Dropped unnecessary <linux/dma-resv.h> inclusion in irdma/main.h.

Changes in v1 (since RFCs):
* Break the interface into a two step process to avoid needing
  extra state in the driver.
* Move the majority of the functionality into the core.

v2: https://lore.kernel.org/linux-rdma/20260302001539.2275303-1-jmoroni@google.com/T/#t
v1: https://lore.kernel.org/linux-rdma/20260225210705.373126-1-jmoroni@google.com/T/#t
RFC v2: https://lore.kernel.org/linux-rdma/20260223195333.438492-1-jmoroni@google.com/T/#t
RFC v1: https://lore.kernel.org/linux-rdma/CAHYDg1TB1Xa+D700WrvrcQVdgZFE5f8iWp48EmQM9XjK9xJdew@mail.gmail.com/T/#t

Jacob Moroni (5):
  RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock helper
  RDMA/umem: Move umem dmabuf revoke logic into helper function
  RDMA/umem: Add pinned revocable dmabuf import interface
  RDMA/umem: Add helpers for umem dmabuf revoke lock
  RDMA/irdma: Add support for revocable pinned dmabuf import

 drivers/infiniband/core/umem_dmabuf.c | 138 ++++++++++++++++++++++----
 drivers/infiniband/hw/irdma/verbs.c   | 105 +++++++++++++++++---
 include/rdma/ib_umem.h                |  23 +++++
 3 files changed, 236 insertions(+), 30 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog


