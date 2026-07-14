Return-Path: <linux-rdma+bounces-23226-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hoVEMqKYVmoF+wAAu9opvQ
	(envelope-from <linux-rdma+bounces-23226-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:14:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C2758AB1
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 22:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BqGVP3fr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23226-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23226-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A7C5314E0CA
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212F441D647;
	Tue, 14 Jul 2026 20:13:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E841F341
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 20:13:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784060014; cv=none; b=k1QwWLIqMlG9AqfRuduTGA7eyeHJzKKhjb1Q2UHjhj1FofYAlJOSK2zXnUawFrhnX3uTYX4nkOrI6jtJFCPmGGRKXMp54KMh+J0mDKN3Jg0UAzLARm0sqtji7U8wNrfWqU1lZh4h8PAWpPQMFup2/M9PM/BBvgLo7a2VgRUG9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784060014; c=relaxed/simple;
	bh=bwr01/9WY7csMe3oixAvNcmOUvWfBdhgJjR3WJyG5E4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nikurc1TEesaHQP26bYZmRLWtVBYh+AgYIZlcNNvYY5y+lx7QyRg52yasQwhKdlW+4Ea+y0fo8Dd/AVRQB4iZQFQMgWkvYcIBMjl5089bEqB1FOEvMJE2ekad0wsA/bM5Jq87I+M4ilNNBliBR4VqSGSQM0s3MWsU7zI0TwjjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqGVP3fr; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84a652535dcso67111b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784060013; x=1784664813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Vc1a4EA+CKVDZWmxoam2W7gn+VW7+IE4FDUnuymM6t4=;
        b=BqGVP3fr3VzcAYMgIEHBrBODNP8u+OiMZeEEj0Sup4UbdHg8E9p+JCzlVbb10OglAe
         QVX7x/AgHKHFCnqyfJdqWvTtvMh61GMPtH1SBZZGBYzNZcv9Cm6cVhV61HGkkzjKceUg
         4J2vlcXWIGc6/k+R/x1EB1wN9wX+rM/uJei10xMgDWeUKfr19ERBBirTSLiQJiHLgyZv
         Jf4fRJNLJziqgmT4YnpaydBF1AOUxCMPhPBnfZVYKNvCWp8C15GhAScasNW3YgNFTl3v
         upuHbaQi5XFirl31yUo9rbXHXSpIPu/SNW1wtiACNrw0SVlZWQdqD0JTJT3eFEkmZMBM
         icuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784060013; x=1784664813;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vc1a4EA+CKVDZWmxoam2W7gn+VW7+IE4FDUnuymM6t4=;
        b=gdo0yNTHjCk7p60adKJWh6k5DKFEiKr9E5K32hq010a6OpV4rXbQBtHbJ89y7fh+vh
         KGIX0XTECAIDRx9o3XC5wW0Eghb4xEx+6fgfVvhD29oVBcxg5JPt8s/VHFoyxHI3nHWr
         o9DJvl4aE8ypAf4d8/cH+8JuG5fybzol+gEDKQwwEOVeR+Bq7FDYx02ZRf/x9tGVm7jZ
         a/t0Jfxxeb1w+97zMwXOyTVKBAeOc4W12YpSGHUBL5APoyn0FDZVo2yfao3jP1VYgl4q
         6Zgmwcyqeyhk72/KWK7nGVTLYmebDAxGSZ+ALOIo9OxDi2BSav4DaVj9MoyNpQvDzLLS
         Bjyw==
X-Forwarded-Encrypted: i=1; AHgh+RowbwCYzAjRRKz4BPkAk6uuDkh4w5E6fs3RrgwkocsqeHEG/diMUiEvQK43i9IW4lVQ6BZnQoKur9xi@vger.kernel.org
X-Gm-Message-State: AOJu0YxXxM4FKd3S5mr9QYcCWa0JAXhOmDKi2fDCLSU2Zm9RwPGIWsnJ
	LnGVJT/4ftjIqXYbd21QPc7a/FoEYabStio5beQ+Zhwcog+2q8JE2Utm
X-Gm-Gg: AfdE7cn+WtOtXTmiVvGw45YitRxtLuGz5uGhRNqqAjMVsmU8krqkqgUzMnuQ724d3k4
	q2DQOJ23YpMQX7vTIaeeT7XEDMcbuJg71uxlSHy1VdKkhzfns13AXnkLElt7BZ6ysbuPQD6OtZm
	0GBWgawxqWHQLQl6fd5+rq4bPprRApUHcQqN9W2cPWL33BSwv4DSR1+qQIo1f867kaHsEvQGJ4R
	h8tAb8/lB5rI0lyIF+MYcCoVBGufuDyTXtf1r2J3qMpiMYyfT2Ub+LhqXj823eyjUD2xn1Khsav
	zKK7nNGY6eVHE7e+u+UJI2n7tOhtqKni/0aWvHMekykQB0yJSdS46pwMJFa1PHe5Vnua+IioVMM
	uJ1uqPYBFBP66xwUJYQsMm2TnPlXogodaDK75kI616vIpEEr6fziM4SL+IppeWRAblX0qnLE4Ll
	mjsrDFDJ41sMrJ4X5Fh/k4jsTtg2bEd64bjN+IHa6KM1cxNPK5uPMUG09FuJQ=
X-Received: by 2002:a05:6a00:2341:b0:848:2f84:f429 with SMTP id d2e1a72fcca58-84a6738a72fmr16414b3a.66.1784060012852;
        Tue, 14 Jul 2026 13:13:32 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6bf5ecsm1974797b3a.29.2026.07.14.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:13:32 -0700 (PDT)
Subject: [PATCH 1/4] fixup! mm/hmm: add hmm_range_fault_unlocked_timeout() for
 mmap lock-drop support
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
Date: Tue, 14 Jul 2026 13:13:31 -0700
Message-ID: <178406001098.1082778.7615814555318834246.stgit@skinsburskii>
In-Reply-To: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
References: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:jgg@ziepe.ca,m:kees@kernel.org,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:skinsburskii@gmail.com,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-23226-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,skinsburskii:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 691C2758AB1

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



