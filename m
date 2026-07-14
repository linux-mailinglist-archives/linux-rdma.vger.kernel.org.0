Return-Path: <linux-rdma+bounces-23234-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IBgSGaS2VmrcAQEAu9opvQ
	(envelope-from <linux-rdma+bounces-23234-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 00:22:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE47592FE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 00:22:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pFM+hxXf;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23234-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23234-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30DE53063C07
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65EF3DDDB8;
	Tue, 14 Jul 2026 22:21:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DD32E729
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 22:21:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067692; cv=none; b=ks7S0s/AdOjk1f6xw0sDnzjh5w74AJRKfEswbls1WojJan/cHfsv6yJcnJpSf/lQ+W1Q27IYZQzbQtdbw43LSmBST5vBkFaqg3fyynVgb6qBd7ARGB92+V79cy5+tVZAs19f0eVPADg7sMl/4h6PCKKYxdCxVQwjIwRcUQhWKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067692; c=relaxed/simple;
	bh=bwr01/9WY7csMe3oixAvNcmOUvWfBdhgJjR3WJyG5E4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUS3i6CueyLMqcfvy3VIF2+RJPaAv7VDi4o5/izpeG0zVbgymfXvWd3za1/Mkjh2+CLJrL+9obcBLGxAfbCO9ycpDDF9fZJH/cDTG4dTpYvsy2AYzXegosUDUyJXfx6bQLlD48P838Y9JGKzdIiYpOpJGwRWwjD3u1vvIim5QLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFM+hxXf; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1616154a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784067691; x=1784672491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vc1a4EA+CKVDZWmxoam2W7gn+VW7+IE4FDUnuymM6t4=;
        b=pFM+hxXfzFnja+aVqNPW9SovupETbvBAdQAZy9VjiPEUkx+xPnbeFY8Sy9DLT8l+RG
         UYtifsORQ6WeMVOcakDxYKwXZk6YM6vujXJyeQGm/Jozr4apH4pwDR0VUQuyYt/m55VG
         4880/fqC2MmP58/NWVVgs6N9dCIIuFF2hcNVU16N2rnbeBCrFvQGVA0zR99UFV/BEqm4
         8RmPxacetvCIjf9FAsfnQH2IoxGUphSZkxRXsaGgXXmh/OS9wS6Pn/9TprTwzTqvBKht
         QI4LCVXsje05oyOd4LlLa/rtoMj10S1a8n58Z8697TLf5jb3SaJ6uCRXhW188Fxc2Ilf
         3YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784067691; x=1784672491;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vc1a4EA+CKVDZWmxoam2W7gn+VW7+IE4FDUnuymM6t4=;
        b=Z7w/OfV++w3S6PWIT6pnAPuOCuTjZKcBLeF+vCtR94fs/TsZ2XndDfjLk9Pvr0LnjW
         Bx5psc3yTC9B+uxonGBhStWSUXUwrxQEcakuzUixu0AvMR+a5/Y1Gfk4DmT+Eeibn77d
         cJRkwEkDDWF8G/puilF0SZwIAYf+NfWok7olu7rAkRn8ppJC3LGOLBFhYJAiRT+sK2EA
         Ilz7yJJgeoRXwv9FfuKzSJ57O3+/2NfUxLUAA4DoxgDMRiK0XpTTl6FXckLrrn+Ah5zN
         9LPN40+d+kiyoznFG2mmIkVm1bGRLZorBuOJMs/DigUJFd0Z3D8wnbmP8senDUisZ+jv
         HfyA==
X-Forwarded-Encrypted: i=1; AHgh+RqNNpaEbtObmhMvpyY9sJjKrYXXrFHv67a3SeyIYAgmqIXWhcQVba0OXzN5spP5YwTY29HSgfITRabw@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVrpE9u1nBim8GjPWBimMDKvMIH2GEpUPsSzD6fidVX72Dnt8
	flKS5D3CDQ13BPJS+mhB5gq1uyq8kucmZHOh4x3C2BiwW+fUYZKk0u6Z
X-Gm-Gg: AfdE7ckYpv9pEd5dcFCQ8nKbE3SJB6aLWuv3uMsAX4FvbtYWvFB84gjQhA9pasbYjHF
	Z63V/0VgZ36huWFXJIxSiMcK0v5vCErv4vMYVdPoP+cZeBwM0b7xFE2JNq8v1N6yr7T9df2Ihv7
	NmK8kvPgHyzKDbB03m21CTMq6NBD7BWcwFu6u3rqiZkvLZ9wNlQyaUvYTUOlSAi4Xu3FdcUDYaR
	/48f19u3jyCbf4KaFBYekBNidw/ePNoLDYwM9VbLCET5Ne2AOMiq6N59H9NkKnfqtyZmfpGSNDq
	Gf7wQ4+8Ci8437J2KWMJistdu6e3u88cgaCx/ZDmyArIUk7746P0mRJ/++Y98Iw5Im+aXfr+Nef
	bEzSr+eo98pG5/YtwuA4PUlcW98uZStzkxMUiitdnHDjvFH6gGrSOSLg55jwrxrKpj9UuHHw2ZS
	K3CjEAWvSWAufN+BsVTRgtNCWQy+6FB8lpOv1lPQ2q9ZfWewhcNkn6xw7DS0A=
X-Received: by 2002:a17:90b:3d4b:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-38dc782ab85mr13404006a91.2.1784067690606;
        Tue, 14 Jul 2026 15:21:30 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172b6d08sm2132074a91.2.2026.07.14.15.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:21:30 -0700 (PDT)
Subject: [PATCH v2 1/4] fixup! mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, jgg@ziepe.ca,
 kees@kernel.org, leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com,
 ljs@kernel.org, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Tue, 14 Jul 2026 15:21:28 -0700
Message-ID: <178406768885.1106335.9955379956617151440.stgit@skinsburskii>
In-Reply-To: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:jgg@ziepe.ca,m:kees@kernel.org,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:skinsburskii@gmail.com,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-23234-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05AE47592FE

The hmm_range_fault_unlocked_timeout() example checks for a concurrent
mmu_interval_notifier invalidation after the HMM fault has succeeded.
The sequence number used for that check is stored in range->notifier_seq
by hmm_range_fault_unlocked_timeout(), so the retry check should use the
same notifier stored in range as well.

Update the example to pass range.notifier to mmu_interval_read_retry(),
and spell out that the retry check uses the notifier and sequence number
stored in range by the HMM fault helper. This makes the relationship
between the HMM walk and the later invalidation check explicit.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 Documentation/mm/hmm.rst |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index 5c88d2cf0818..fc1b8dc19825 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -206,7 +206,7 @@ The usage pattern is::
           goto out_put;
 
       take_lock(driver->update);
-      if (mmu_interval_read_retry(&interval_sub, range.notifier_seq)) {
+      if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
           release_lock(driver->update);
           goto again;
       }
@@ -225,7 +225,8 @@ The usage pattern is::
 The driver->update lock is the same lock that the driver takes inside its
 invalidate() callback. That lock must be held before calling
 mmu_interval_read_retry() to avoid any race with a concurrent CPU page table
-update.
+update. The retry check must use the same notifier and sequence number stored
+in ``range`` by ``hmm_range_fault_unlocked_timeout()``.
 
 Holding the mmap lock across HMM faults
 =======================================



