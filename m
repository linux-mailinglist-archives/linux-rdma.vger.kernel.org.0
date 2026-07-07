Return-Path: <linux-rdma+bounces-22853-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q4xACuFXTWqNygEAu9opvQ
	(envelope-from <linux-rdma+bounces-22853-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 21:47:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFC71F5D4
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 21:47:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=i4DAliPF;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22853-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22853-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96DC0300A26B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8A420881;
	Tue,  7 Jul 2026 19:47:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3353B7750
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2026 19:47:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453633; cv=none; b=jaLD/T07E2eu1FEXFm6eXjlb2B7HxZkwwazQBHVI1STv3Q6MPhK+BHdn5QjNA5vCGY4zRjcud63pLeG7JCUIWqKSvcKajPs4csiqs0PRoC1psKyuC6NPbKGgP2bQqS1DENAZMC6paDfawE1uezcrharVFGffBWfpw6kHYGvpRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453633; c=relaxed/simple;
	bh=1S3y9WpMDRE1WsWfhe0ks0QvWybFhHgjKqHPSJuw9Qg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVhwrTB4CDzFfuOC9vebDOayfJ1eImNGJ+GgSwiHxuWdIEtQopELIyXvQ3KL3L7S1b37xWGkuytarupM15y9pt11IyZzdKhmpd4+sRtPx6pWAKWukQLXE9DtPnns+yYVe5o9KDz6zuXxgLZ0B1qExqQz6FooK2ErLxSEadam0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4DAliPF; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3811e59df58so2883610a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2026 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783453631; x=1784058431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L2IYT3wu5l+zIbtBD2s88iZ7TNagS/VHstd2UWbDbN8=;
        b=i4DAliPF+hlpmlxrw+28gERojfnxdVc3sjrijDtyg9nJfLFVMT80sOQKYZ6epYWMdA
         CXx/HJ7tmKaRjEWa3dHZqKzWPZNVYpYR76r0EEMy55J967ZDFDTKizQ5mX7pB11+x8UL
         HSVZqnS+citpTdpBoDWBlBUzpt5m/rUslse8w6py8Q7sJWMwXSpmYeCf7MoUyPFo5aKh
         0NyLC3dWpdvdvw6V9Y5GzWf5d/3qFxFrWiaY8DJmpvnbTZdd8an8eaGeFBDmq9I5X9uw
         OwPxMql3FMsbZvqvNoQybOUtXAuklR/wg4ONRChpqHOQ/B+dhT5sAVfTJcWB9M5RH2AB
         oeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453631; x=1784058431;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2IYT3wu5l+zIbtBD2s88iZ7TNagS/VHstd2UWbDbN8=;
        b=QD1RrGX7Yb7HpkG7/WCHK4YbSP+CX0g0KqG5aCYaCS3lC9rsfhVhq5urUYbeH7/q8/
         H57nobeSwza4KfYcJG60PA9Nit9vqG/W+SxtVspOwaHYAehVVrrYTdcg86SOYelc1UVe
         oe68tZ3lENs4laXNeBaC4IyIfeVwsSpfwvq35ms3l5N22SSYUiIAsVbQE7cpoUf6DSvy
         mzMsUX1J5NbtShg5GuAG8ka3aTRSkGLIKKjH9p8Ar9Fl2QOop8NZrFr5E1HTUUrXKA8j
         fk4Iq5RxFo0+1FfVBFP6FvdXz49mhLCxitdNARThuUeTTNLfu5VX4XLiDYN0t80mD65c
         0Dwg==
X-Forwarded-Encrypted: i=1; AHgh+RrUKMHUY+suIZCdGDcFDURmFxJjub5vVjrnr7miToyvaNMRZRqL336ug8zUi+mgPJf4fwIbL6t9bj8T@vger.kernel.org
X-Gm-Message-State: AOJu0YyFO3wR79jjALBvkl0ivfyyd7RnBLxmedkfpeOj1E3DUS2jyvjp
	+MkjmcsSQpIxCBIcGjp52AAuEtlnoBtegiNjxUgb5fr+0aiYXwUIJI/I2zzyEA==
X-Gm-Gg: AfdE7cnJGxD0GXfnDdt2WIaE3dYwfKbGoK4NAvf9rvweabXEWp2fyARkZpaNbmJsebq
	02lB03wUbDqwhuv7m1OJ6AL5RQYXU0Y8pX009S/gj7LhLhM2M51o92Hi9iMKUxmeGW85anP1fzG
	tkhgJRBIv0XZrjRyidzCM5gdvGYqtdNzFiCyRLC7VymI6vSra9f7ViphgMUckhR/RRoBOMpFti9
	fumSxHeTB/ODjF3E10ih9iDVwHUZu0HAfdXY/JE4X4F1lr4FE0Gn0cqMoehkIZdEzN4xmNpm4R7
	ss1MeI8iULxq6w5bfCVWu0Fg1FDiEmjKGlzTCHhypMpQaD4NyBAg9r8jjr+p8v16nHUsf+WB2Z5
	VMaOpBSujW1n/9rwip6hnprE1JONNJY2dcQ5XmEzy0qTGcsB6dTrTrAveqVe5OjI+ABadRKBfcC
	qQIPm7vlT5RBJgEWuI0TQloiadkMUx2gJtw1a3BLUPZND2TuHBuAMz8dsUj9U=
X-Received: by 2002:a17:90b:5683:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-3875298135amr6064743a91.0.1783453630717;
        Tue, 07 Jul 2026 12:47:10 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d36676desm1639922a91.10.2026.07.07.12.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:47:10 -0700 (PDT)
Subject: [PATCH v7 3/8] selftests/mm: add HMM tests for mmap lock-dropping
 faults
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Tue, 07 Jul 2026 12:47:08 -0700
Message-ID: <178345362882.660027.7469490514544148781.stgit@skinsburskii>
In-Reply-To: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
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
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22853-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,ziepe.ca,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:jgg@ziepe.ca,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:skinsburskii@gmail.com,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,skinsburskii:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AFFC71F5D4

Add test_hmm coverage for the HMM lock-dropping fault path. The test module
gets new HMM_DMIRROR_READ_UNLOCKED and HMM_DMIRROR_READ_UNLOCKED_TIMEOUT
ioctls that both call hmm_range_fault_unlocked_timeout(). The unlocked
ioctl passes a timeout of 0 to exercise the unbounded retry mode, while the
timeout ioctl passes HMM_RANGE_DEFAULT_TIMEOUT converted to jiffies.

Add a userfaultfd_read selftest that registers an anonymous mapping with
UFFDIO_REGISTER_MODE_MISSING, services the faults from a handler thread
with UFFDIO_COPY, and verifies that HMM can read back the data supplied by
the handler. This exercises the path where handle_mm_fault() drops
mmap_lock and hmm_range_fault_unlocked_timeout() restarts the walk
internally.

Add a userfaultfd_timeout selftest for the finite-timeout mode. It
registers a missing-mode userfaultfd range without a data-supplying
handler, then closes the userfaultfd after the timeout window so the
blocked fault can unwind and hmm_range_fault_unlocked_timeout() can return
-EBUSY.

Assisted-by: GitHub-Copilot:claude-opus-4.6
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 lib/test_hmm.c                         |  111 ++++++++++++++++
 lib/test_hmm_uapi.h                    |    3 
 tools/testing/selftests/mm/hmm-tests.c |  220 ++++++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 45c0cb992218..02a98887c290 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -389,6 +389,67 @@ static int dmirror_range_fault(struct dmirror *dmirror,
 	return ret;
 }
 
+static int dmirror_range_fault_unlocked(struct dmirror *dmirror,
+					struct hmm_range *range,
+					unsigned long timeout)
+{
+	int ret;
+
+	while (true) {
+		ret = hmm_range_fault_unlocked_timeout(range, timeout);
+		if (ret)
+			goto out;
+
+		mutex_lock(&dmirror->mutex);
+		if (mmu_interval_read_retry(range->notifier,
+					    range->notifier_seq)) {
+			mutex_unlock(&dmirror->mutex);
+			continue;
+		}
+		break;
+	}
+
+	ret = dmirror_do_fault(dmirror, range);
+
+	mutex_unlock(&dmirror->mutex);
+out:
+	return ret;
+}
+
+static int dmirror_fault_unlocked(struct dmirror *dmirror,
+				  unsigned long start,
+				  unsigned long end, bool write,
+				  unsigned long timeout)
+{
+	struct mm_struct *mm = dmirror->notifier.mm;
+	unsigned long addr;
+	unsigned long pfns[32];
+	struct hmm_range range = {
+		.notifier = &dmirror->notifier,
+		.hmm_pfns = pfns,
+		.pfn_flags_mask = 0,
+		.default_flags =
+			HMM_PFN_REQ_FAULT | (write ? HMM_PFN_REQ_WRITE : 0),
+		.dev_private_owner = dmirror->mdevice,
+	};
+	int ret = 0;
+
+	if (!mmget_not_zero(mm))
+		return -EFAULT;
+
+	for (addr = start; addr < end; addr = range.end) {
+		range.start = addr;
+		range.end = min(addr + (ARRAY_SIZE(pfns) << PAGE_SHIFT), end);
+
+		ret = dmirror_range_fault_unlocked(dmirror, &range, timeout);
+		if (ret)
+			break;
+	}
+
+	mmput(mm);
+	return ret;
+}
+
 static int dmirror_fault(struct dmirror *dmirror, unsigned long start,
 			 unsigned long end, bool write)
 {
@@ -488,6 +549,48 @@ static int dmirror_read(struct dmirror *dmirror, struct hmm_dmirror_cmd *cmd)
 	return ret;
 }
 
+static int dmirror_read_unlocked(struct dmirror *dmirror,
+				 struct hmm_dmirror_cmd *cmd,
+				 unsigned long timeout)
+{
+	struct dmirror_bounce bounce;
+	unsigned long start, end;
+	unsigned long size = cmd->npages << PAGE_SHIFT;
+	int ret;
+
+	start = cmd->addr;
+	end = start + size;
+	if (end < start)
+		return -EINVAL;
+
+	ret = dmirror_bounce_init(&bounce, start, size);
+	if (ret)
+		return ret;
+
+	while (1) {
+		mutex_lock(&dmirror->mutex);
+		ret = dmirror_do_read(dmirror, start, end, &bounce);
+		mutex_unlock(&dmirror->mutex);
+		if (ret != -ENOENT)
+			break;
+
+		start = cmd->addr + (bounce.cpages << PAGE_SHIFT);
+		ret = dmirror_fault_unlocked(dmirror, start, end, false, timeout);
+		if (ret)
+			break;
+		cmd->faults++;
+	}
+
+	if (ret == 0) {
+		if (copy_to_user(u64_to_user_ptr(cmd->ptr), bounce.ptr,
+				 bounce.size))
+			ret = -EFAULT;
+	}
+	cmd->cpages = bounce.cpages;
+	dmirror_bounce_fini(&bounce);
+	return ret;
+}
+
 static int dmirror_do_write(struct dmirror *dmirror, unsigned long start,
 			    unsigned long end, struct dmirror_bounce *bounce)
 {
@@ -1572,6 +1675,14 @@ static long dmirror_fops_unlocked_ioctl(struct file *filp,
 		dmirror->flags = cmd.npages;
 		ret = 0;
 		break;
+	case HMM_DMIRROR_READ_UNLOCKED:
+		ret = dmirror_read_unlocked(dmirror, &cmd, 0);
+		break;
+	case HMM_DMIRROR_READ_UNLOCKED_TIMEOUT:
+		ret = dmirror_read_unlocked(dmirror, &cmd,
+				msecs_to_jiffies(
+					HMM_RANGE_DEFAULT_TIMEOUT));
+		break;
 
 	default:
 		return -EINVAL;
diff --git a/lib/test_hmm_uapi.h b/lib/test_hmm_uapi.h
index f94c6d457338..249ab2d9e3b2 100644
--- a/lib/test_hmm_uapi.h
+++ b/lib/test_hmm_uapi.h
@@ -38,6 +38,9 @@ struct hmm_dmirror_cmd {
 #define HMM_DMIRROR_CHECK_EXCLUSIVE	_IOWR('H', 0x06, struct hmm_dmirror_cmd)
 #define HMM_DMIRROR_RELEASE		_IOWR('H', 0x07, struct hmm_dmirror_cmd)
 #define HMM_DMIRROR_FLAGS		_IOWR('H', 0x08, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_READ_UNLOCKED	_IOWR('H', 0x09, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_READ_UNLOCKED_TIMEOUT \
+	_IOWR('H', 0x0a, struct hmm_dmirror_cmd)
 
 #define HMM_DMIRROR_FLAG_FAIL_ALLOC	(1ULL << 0)
 
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 2f2b9879d100..dc031d2e2aae 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -29,6 +29,10 @@
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 #include <sys/time.h>
+#include <sys/syscall.h>
+#include <sys/eventfd.h>
+#include <linux/userfaultfd.h>
+#include <poll.h>
 
 /*
  * This is a private UAPI to the kernel test module so it isn't exported
@@ -2949,4 +2953,220 @@ TEST_F_TIMEOUT(hmm, benchmark_thp_migration, 120)
 					&thp_results, &regular_results);
 	}
 }
+/*
+ * Test that HMM can fault in pages backed by userfaultfd using the
+ * hmm_range_fault_unlocked_timeout() path with no timeout. This exercises
+ * the lock-drop retry logic in the HMM framework.
+ */
+struct uffd_thread_args {
+	int uffd;
+	int stop_fd;
+	void *page_buffer;
+	unsigned long page_size;
+};
+
+static void *uffd_handler_thread(void *arg)
+{
+	struct uffd_thread_args *args = arg;
+	struct uffd_msg msg;
+	struct uffdio_copy copy;
+	struct pollfd pollfd[2];
+	int ret;
+
+	pollfd[0].fd = args->uffd;
+	pollfd[0].events = POLLIN;
+	pollfd[1].fd = args->stop_fd;
+	pollfd[1].events = POLLIN;
+
+	while (1) {
+		ret = poll(pollfd, 2, -1);
+		if (ret <= 0)
+			break;
+		if (pollfd[1].revents)
+			break;
+		if (!(pollfd[0].revents & POLLIN))
+			break;
+
+		ret = read(args->uffd, &msg, sizeof(msg));
+		if (ret != sizeof(msg))
+			break;
+
+		if (msg.event != UFFD_EVENT_PAGEFAULT)
+			break;
+
+		/* Fill the page with a known pattern */
+		memset(args->page_buffer, 0xAB, args->page_size);
+
+		copy.dst = msg.arg.pagefault.address & ~(args->page_size - 1);
+		copy.src = (unsigned long)args->page_buffer;
+		copy.len = args->page_size;
+		copy.mode = 0;
+		copy.copy = 0;
+
+		ret = ioctl(args->uffd, UFFDIO_COPY, &copy);
+		if (ret < 0)
+			break;
+	}
+
+	return NULL;
+}
+
+struct uffd_close_args {
+	int uffd;
+	unsigned int delay_us;
+};
+
+static void *uffd_close_thread(void *arg)
+{
+	struct uffd_close_args *args = arg;
+
+	usleep(args->delay_us);
+	close(args->uffd);
+	return NULL;
+}
+
+TEST_F(hmm, userfaultfd_read)
+{
+	struct hmm_buffer *buffer;
+	struct uffd_thread_args uffd_args;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	unsigned char *ptr;
+	pthread_t thread;
+	int uffd;
+	int stop_fd;
+	int ret;
+	struct uffdio_api api;
+	struct uffdio_register reg;
+	uint64_t stop = 1;
+	ssize_t nwrite;
+
+	npages = 4;
+	size = npages << self->page_shift;
+
+	/* Create userfaultfd */
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0)
+		SKIP(return, "userfaultfd not available");
+
+	api.api = UFFD_API;
+	api.features = 0;
+	ret = ioctl(uffd, UFFDIO_API, &api);
+	ASSERT_EQ(ret, 0);
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	/* Create anonymous mapping */
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   -1, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Register the region with userfaultfd */
+	reg.range.start = (unsigned long)buffer->ptr;
+	reg.range.len = size;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	ret = ioctl(uffd, UFFDIO_REGISTER, &reg);
+	ASSERT_EQ(ret, 0);
+
+	/* Set up the handler thread */
+	uffd_args.uffd = uffd;
+	stop_fd = eventfd(0, EFD_CLOEXEC);
+	ASSERT_GE(stop_fd, 0);
+	uffd_args.stop_fd = stop_fd;
+	uffd_args.page_buffer = malloc(self->page_size);
+	ASSERT_NE(uffd_args.page_buffer, NULL);
+	uffd_args.page_size = self->page_size;
+
+	ret = pthread_create(&thread, NULL, uffd_handler_thread, &uffd_args);
+	ASSERT_EQ(ret, 0);
+
+	/*
+	 * Use the unlocked read path which allows the mmap lock to be
+	 * dropped during the fault, enabling userfaultfd resolution.
+	 */
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ_UNLOCKED,
+			      buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Verify the device read the data filled by the uffd handler */
+	ptr = buffer->mirror;
+	for (i = 0; i < size; ++i)
+		ASSERT_EQ(ptr[i], (unsigned char)0xAB);
+
+	nwrite = write(stop_fd, &stop, sizeof(stop));
+	ASSERT_EQ(nwrite, sizeof(stop));
+	pthread_join(thread, NULL);
+	close(stop_fd);
+	free(uffd_args.page_buffer);
+	close(uffd);
+	hmm_buffer_free(buffer);
+}
+
+TEST_F(hmm, userfaultfd_timeout)
+{
+	struct uffd_close_args close_args;
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	pthread_t thread;
+	int uffd;
+	int ret;
+	struct uffdio_api api;
+	struct uffdio_register reg;
+
+	npages = 4;
+	size = npages << self->page_shift;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0)
+		SKIP(return, "userfaultfd not available");
+
+	api.api = UFFD_API;
+	api.features = 0;
+	ret = ioctl(uffd, UFFDIO_API, &api);
+	ASSERT_EQ(ret, 0);
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   -1, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	reg.range.start = (unsigned long)buffer->ptr;
+	reg.range.len = size;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	ret = ioctl(uffd, UFFDIO_REGISTER, &reg);
+	ASSERT_EQ(ret, 0);
+
+	close_args.uffd = uffd;
+	close_args.delay_us = 1500 * 1000;
+	ret = pthread_create(&thread, NULL, uffd_close_thread, &close_args);
+	ASSERT_EQ(ret, 0);
+
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_READ_UNLOCKED_TIMEOUT,
+			    buffer, npages);
+	pthread_join(thread, NULL);
+	ASSERT_EQ(ret, -EBUSY);
+
+	hmm_buffer_free(buffer);
+}
+
 TEST_HARNESS_MAIN



