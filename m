Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC024BBB6
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfFSOeG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 10:34:06 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:34913 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOeG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 10:34:06 -0400
Received: by mail-io1-f48.google.com with SMTP id m24so38725251ioo.2;
        Wed, 19 Jun 2019 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QYkOxg028hCIPhtp7+LeSW93hyCu1yxK73hJ1SLMNXg=;
        b=QkB67w5zWlT8yC/qq+lVzr1i9HLX99zhf2uFjBkHjwEjwt9OnOhHSOZCpoEYyf/Bno
         j0MIPUGfZamT3Is7QYuxxtiIhY3xinXhSwPi5vhEVixCbCvnks4v+ukGnXL2+hPeOmqh
         3iOUJjwjrvbheV6t4GHTOncS1Yv2w9yNHMxjd1btGJ1rP+fl/OYQSnxM5hzwtSSs48lc
         uHNPR+6OKtIp9jgK0w0fgI+xGzG6o77p0GnNd00nP2hDxAM3nU7dXqjWjaE3oXUnhMYQ
         W5u7ueJ9jYGNEpRKfqO1hOqHGauoPvQq6uqjiifkR7X2cL17ULGxgoVz5i5zXKru6b4K
         gRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=QYkOxg028hCIPhtp7+LeSW93hyCu1yxK73hJ1SLMNXg=;
        b=B90HuZx4Fc/BZVX/w/aNMlN04AKV7zG0THw4VJ1QwBDZLfVrA0Nvp0FUkzkLo1W1GG
         5W2jRfmzntXmv5tkOiyxd+kV66xhmGKtEpedc/sKtxY54p0u0oSFbpcQ/5OvFCUWeh+E
         qCd5aSfH/vMt7jgXVTue+FJl5yfxv1stuAZ2fbXG80XcvyB86GxZZmKe/sBUK/0wUU28
         CFBEjjbapP4wI7SGyPmr/h6RwW0lUmtr8rlxeoOdQ1AlYEx6QVYYifS/5EJdQT9se8Sb
         BpTsvv+790Ooy7uqnTJk20tLdPdFAEdbDj5p60yJUBNbd2GgjBo7WguGCTAsnS81oRw/
         dESg==
X-Gm-Message-State: APjAAAW9yAHZt0/vXBqZFU6fCzAq35AoutcGxNhJANN3a4pFOIpSmXcT
        etbqOfB100Yfgf2HpapUpDs=
X-Google-Smtp-Source: APXvYqxidPR4248I4TZS8xsLLyBYudHHaktMJybNxumFPjn4vEvL39O9AU3FuGKFULorYiB9N16lTA==
X-Received: by 2002:a02:77d6:: with SMTP id g205mr65385631jac.13.1560954845081;
        Wed, 19 Jun 2019 07:34:05 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m7sm12421402iob.69.2019.06.19.07.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:34:04 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEY3h6004545;
        Wed, 19 Jun 2019 14:34:03 GMT
Subject: [PATCH v4 18/19] NFS: Update symbolic flags displayed by trace
 events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:34:03 -0400
Message-ID: <20190619143403.3826.95915.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add missing symbolic flag names and display flags variables in
hexadecimal to improve observability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |  150 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 124 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 9dd8765..cd09356 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -11,6 +11,16 @@
 #include <linux/tracepoint.h>
 #include <linux/iversion.h>
 
+TRACE_DEFINE_ENUM(DT_UNKNOWN);
+TRACE_DEFINE_ENUM(DT_FIFO);
+TRACE_DEFINE_ENUM(DT_CHR);
+TRACE_DEFINE_ENUM(DT_DIR);
+TRACE_DEFINE_ENUM(DT_BLK);
+TRACE_DEFINE_ENUM(DT_REG);
+TRACE_DEFINE_ENUM(DT_LNK);
+TRACE_DEFINE_ENUM(DT_SOCK);
+TRACE_DEFINE_ENUM(DT_WHT);
+
 #define nfs_show_file_type(ftype) \
 	__print_symbolic(ftype, \
 			{ DT_UNKNOWN, "UNKNOWN" }, \
@@ -23,25 +33,57 @@
 			{ DT_SOCK, "SOCK" }, \
 			{ DT_WHT, "WHT" })
 
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_DATA);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_ATIME);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_ACCESS);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_ACL);
+TRACE_DEFINE_ENUM(NFS_INO_REVAL_PAGECACHE);
+TRACE_DEFINE_ENUM(NFS_INO_REVAL_FORCED);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_LABEL);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_CHANGE);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_CTIME);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_MTIME);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_SIZE);
+TRACE_DEFINE_ENUM(NFS_INO_INVALID_OTHER);
+
 #define nfs_show_cache_validity(v) \
 	__print_flags(v, "|", \
-			{ NFS_INO_INVALID_ATTR, "INVALID_ATTR" }, \
 			{ NFS_INO_INVALID_DATA, "INVALID_DATA" }, \
 			{ NFS_INO_INVALID_ATIME, "INVALID_ATIME" }, \
 			{ NFS_INO_INVALID_ACCESS, "INVALID_ACCESS" }, \
 			{ NFS_INO_INVALID_ACL, "INVALID_ACL" }, \
 			{ NFS_INO_REVAL_PAGECACHE, "REVAL_PAGECACHE" }, \
 			{ NFS_INO_REVAL_FORCED, "REVAL_FORCED" }, \
-			{ NFS_INO_INVALID_LABEL, "INVALID_LABEL" })
+			{ NFS_INO_INVALID_LABEL, "INVALID_LABEL" }, \
+			{ NFS_INO_INVALID_CHANGE, "INVALID_CHANGE" }, \
+			{ NFS_INO_INVALID_CTIME, "INVALID_CTIME" }, \
+			{ NFS_INO_INVALID_MTIME, "INVALID_MTIME" }, \
+			{ NFS_INO_INVALID_SIZE, "INVALID_SIZE" }, \
+			{ NFS_INO_INVALID_OTHER, "INVALID_OTHER" })
+
+TRACE_DEFINE_ENUM(NFS_INO_ADVISE_RDPLUS);
+TRACE_DEFINE_ENUM(NFS_INO_STALE);
+TRACE_DEFINE_ENUM(NFS_INO_ACL_LRU_SET);
+TRACE_DEFINE_ENUM(NFS_INO_INVALIDATING);
+TRACE_DEFINE_ENUM(NFS_INO_FSCACHE);
+TRACE_DEFINE_ENUM(NFS_INO_FSCACHE_LOCK);
+TRACE_DEFINE_ENUM(NFS_INO_LAYOUTCOMMIT);
+TRACE_DEFINE_ENUM(NFS_INO_LAYOUTCOMMITTING);
+TRACE_DEFINE_ENUM(NFS_INO_LAYOUTSTATS);
+TRACE_DEFINE_ENUM(NFS_INO_ODIRECT);
 
 #define nfs_show_nfsi_flags(v) \
 	__print_flags(v, "|", \
-			{ 1 << NFS_INO_ADVISE_RDPLUS, "ADVISE_RDPLUS" }, \
-			{ 1 << NFS_INO_STALE, "STALE" }, \
-			{ 1 << NFS_INO_INVALIDATING, "INVALIDATING" }, \
-			{ 1 << NFS_INO_FSCACHE, "FSCACHE" }, \
-			{ 1 << NFS_INO_LAYOUTCOMMIT, "NEED_LAYOUTCOMMIT" }, \
-			{ 1 << NFS_INO_LAYOUTCOMMITTING, "LAYOUTCOMMIT" })
+			{ BIT(NFS_INO_ADVISE_RDPLUS), "ADVISE_RDPLUS" }, \
+			{ BIT(NFS_INO_STALE), "STALE" }, \
+			{ BIT(NFS_INO_ACL_LRU_SET), "ACL_LRU_SET" }, \
+			{ BIT(NFS_INO_INVALIDATING), "INVALIDATING" }, \
+			{ BIT(NFS_INO_FSCACHE), "FSCACHE" }, \
+			{ BIT(NFS_INO_FSCACHE_LOCK), "FSCACHE_LOCK" }, \
+			{ BIT(NFS_INO_LAYOUTCOMMIT), "NEED_LAYOUTCOMMIT" }, \
+			{ BIT(NFS_INO_LAYOUTCOMMITTING), "LAYOUTCOMMIT" }, \
+			{ BIT(NFS_INO_LAYOUTSTATS), "LAYOUTSTATS" }, \
+			{ BIT(NFS_INO_ODIRECT), "ODIRECT" })
 
 DECLARE_EVENT_CLASS(nfs_inode_event,
 		TP_PROTO(
@@ -110,7 +152,7 @@
 		TP_printk(
 			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"type=%u (%s) version=%llu size=%lld "
-			"cache_validity=%lu (%s) nfs_flags=%ld (%s)",
+			"cache_validity=0x%lx (%s) nfs_flags=0x%lx (%s)",
 			-__entry->error, nfs_show_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -158,13 +200,41 @@
 DEFINE_NFS_INODE_EVENT(nfs_access_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_access_exit);
 
+TRACE_DEFINE_ENUM(LOOKUP_FOLLOW);
+TRACE_DEFINE_ENUM(LOOKUP_DIRECTORY);
+TRACE_DEFINE_ENUM(LOOKUP_AUTOMOUNT);
+TRACE_DEFINE_ENUM(LOOKUP_PARENT);
+TRACE_DEFINE_ENUM(LOOKUP_REVAL);
+TRACE_DEFINE_ENUM(LOOKUP_RCU);
+TRACE_DEFINE_ENUM(LOOKUP_NO_REVAL);
+TRACE_DEFINE_ENUM(LOOKUP_NO_EVAL);
+TRACE_DEFINE_ENUM(LOOKUP_OPEN);
+TRACE_DEFINE_ENUM(LOOKUP_CREATE);
+TRACE_DEFINE_ENUM(LOOKUP_EXCL);
+TRACE_DEFINE_ENUM(LOOKUP_RENAME_TARGET);
+TRACE_DEFINE_ENUM(LOOKUP_JUMPED);
+TRACE_DEFINE_ENUM(LOOKUP_ROOT);
+TRACE_DEFINE_ENUM(LOOKUP_EMPTY);
+TRACE_DEFINE_ENUM(LOOKUP_DOWN);
+
 #define show_lookup_flags(flags) \
-	__print_flags((unsigned long)flags, "|", \
-			{ LOOKUP_AUTOMOUNT, "AUTOMOUNT" }, \
+	__print_flags(flags, "|", \
+			{ LOOKUP_FOLLOW, "FOLLOW" }, \
 			{ LOOKUP_DIRECTORY, "DIRECTORY" }, \
+			{ LOOKUP_AUTOMOUNT, "AUTOMOUNT" }, \
+			{ LOOKUP_PARENT, "PARENT" }, \
+			{ LOOKUP_REVAL, "REVAL" }, \
+			{ LOOKUP_RCU, "RCU" }, \
+			{ LOOKUP_NO_REVAL, "NO_REVAL" }, \
+			{ LOOKUP_NO_EVAL, "NO_EVAL" }, \
 			{ LOOKUP_OPEN, "OPEN" }, \
 			{ LOOKUP_CREATE, "CREATE" }, \
-			{ LOOKUP_EXCL, "EXCL" })
+			{ LOOKUP_EXCL, "EXCL" }, \
+			{ LOOKUP_RENAME_TARGET, "RENAME_TARGET" }, \
+			{ LOOKUP_JUMPED, "JUMPED" }, \
+			{ LOOKUP_ROOT, "ROOT" }, \
+			{ LOOKUP_EMPTY, "EMPTY" }, \
+			{ LOOKUP_DOWN, "DOWN" })
 
 DECLARE_EVENT_CLASS(nfs_lookup_event,
 		TP_PROTO(
@@ -176,7 +246,7 @@
 		TP_ARGS(dir, dentry, flags),
 
 		TP_STRUCT__entry(
-			__field(unsigned int, flags)
+			__field(unsigned long, flags)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, dentry->d_name.name)
@@ -190,7 +260,7 @@
 		),
 
 		TP_printk(
-			"flags=%u (%s) name=%02x:%02x:%llu/%s",
+			"flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			__entry->flags,
 			show_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -220,7 +290,7 @@
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(unsigned int, flags)
+			__field(unsigned long, flags)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, dentry->d_name.name)
@@ -235,7 +305,7 @@
 		),
 
 		TP_printk(
-			"error=%ld (%s) flags=%u (%s) name=%02x:%02x:%llu/%s",
+			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
 			show_lookup_flags(__entry->flags),
@@ -260,15 +330,43 @@
 DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_enter);
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_exit);
 
+TRACE_DEFINE_ENUM(O_WRONLY);
+TRACE_DEFINE_ENUM(O_RDWR);
+TRACE_DEFINE_ENUM(O_CREAT);
+TRACE_DEFINE_ENUM(O_EXCL);
+TRACE_DEFINE_ENUM(O_NOCTTY);
+TRACE_DEFINE_ENUM(O_TRUNC);
+TRACE_DEFINE_ENUM(O_APPEND);
+TRACE_DEFINE_ENUM(O_NONBLOCK);
+TRACE_DEFINE_ENUM(O_DSYNC);
+TRACE_DEFINE_ENUM(O_DIRECT);
+TRACE_DEFINE_ENUM(O_LARGEFILE);
+TRACE_DEFINE_ENUM(O_DIRECTORY);
+TRACE_DEFINE_ENUM(O_NOFOLLOW);
+TRACE_DEFINE_ENUM(O_NOATIME);
+TRACE_DEFINE_ENUM(O_CLOEXEC);
+
 #define show_open_flags(flags) \
-	__print_flags((unsigned long)flags, "|", \
+	__print_flags(flags, "|", \
+		{ O_WRONLY, "O_WRONLY" }, \
+		{ O_RDWR, "O_RDWR" }, \
 		{ O_CREAT, "O_CREAT" }, \
 		{ O_EXCL, "O_EXCL" }, \
+		{ O_NOCTTY, "O_NOCTTY" }, \
 		{ O_TRUNC, "O_TRUNC" }, \
 		{ O_APPEND, "O_APPEND" }, \
+		{ O_NONBLOCK, "O_NONBLOCK" }, \
 		{ O_DSYNC, "O_DSYNC" }, \
 		{ O_DIRECT, "O_DIRECT" }, \
-		{ O_DIRECTORY, "O_DIRECTORY" })
+		{ O_LARGEFILE, "O_LARGEFILE" }, \
+		{ O_DIRECTORY, "O_DIRECTORY" }, \
+		{ O_NOFOLLOW, "O_NOFOLLOW" }, \
+		{ O_NOATIME, "O_NOATIME" }, \
+		{ O_CLOEXEC, "O_CLOEXEC" })
+
+TRACE_DEFINE_ENUM(FMODE_READ);
+TRACE_DEFINE_ENUM(FMODE_WRITE);
+TRACE_DEFINE_ENUM(FMODE_EXEC);
 
 #define show_fmode_flags(mode) \
 	__print_flags(mode, "|", \
@@ -286,7 +384,7 @@
 		TP_ARGS(dir, ctx, flags),
 
 		TP_STRUCT__entry(
-			__field(unsigned int, flags)
+			__field(unsigned long, flags)
 			__field(unsigned int, fmode)
 			__field(dev_t, dev)
 			__field(u64, dir)
@@ -302,7 +400,7 @@
 		),
 
 		TP_printk(
-			"flags=%u (%s) fmode=%s name=%02x:%02x:%llu/%s",
+			"flags=0x%lx (%s) fmode=%s name=%02x:%02x:%llu/%s",
 			__entry->flags,
 			show_open_flags(__entry->flags),
 			show_fmode_flags(__entry->fmode),
@@ -324,7 +422,7 @@
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(unsigned int, flags)
+			__field(unsigned long, flags)
 			__field(unsigned int, fmode)
 			__field(dev_t, dev)
 			__field(u64, dir)
@@ -341,7 +439,7 @@
 		),
 
 		TP_printk(
-			"error=%ld (%s) flags=%u (%s) fmode=%s "
+			"error=%ld (%s) flags=0x%lx (%s) fmode=%s "
 			"name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
@@ -363,7 +461,7 @@
 		TP_ARGS(dir, dentry, flags),
 
 		TP_STRUCT__entry(
-			__field(unsigned int, flags)
+			__field(unsigned long, flags)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, dentry->d_name.name)
@@ -377,7 +475,7 @@
 		),
 
 		TP_printk(
-			"flags=%u (%s) name=%02x:%02x:%llu/%s",
+			"flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			__entry->flags,
 			show_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -398,7 +496,7 @@
 
 		TP_STRUCT__entry(
 			__field(unsigned long, error)
-			__field(unsigned int, flags)
+			__field(unsigned long, flags)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, dentry->d_name.name)
@@ -413,7 +511,7 @@
 		),
 
 		TP_printk(
-			"error=%ld (%s) flags=%u (%s) name=%02x:%02x:%llu/%s",
+			"error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
 			-__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
 			show_open_flags(__entry->flags),

