Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9399C3D061
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404312AbfFKPJb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 11:09:31 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55264 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404180AbfFKPJb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 11:09:31 -0400
Received: by mail-it1-f195.google.com with SMTP id m138so5480202ita.4;
        Tue, 11 Jun 2019 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=6igB3MhLPHzYbqJh3QxD/LpzghtdN3ydlP1i4u38xt0=;
        b=bh+WFnTB0C8H4ksXI1ARKqBsshnGGQ5GKbpZOhd/16HHMT8oN3abme6jdsSYBRrYBI
         DiAV/oiyEnIEXJmeBzxHwMHb7wY15efYIViu8mSVEWhR0a0EqDGaT+tlC+QoYCBvTKsH
         P/KTKG1Sp9ybKnIvhyhDJDNOdc0SjEs7HxU9wwxmqcUHIca81Tl6RrtU6lkVLcZd6eqk
         D+iJCEcji55BFgiuiCStCXErKWX8Mpxwd0jXhvL+u5SUr5++gdmGv1Ad7iVUbOTY/crl
         nJl1o5Jc+cR4HvQw98G4YyLAX5rKeSZuPqezietwQTY0mpkVkKpeKsuyaAU0X2fXD8VT
         C6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=6igB3MhLPHzYbqJh3QxD/LpzghtdN3ydlP1i4u38xt0=;
        b=PP0MDYbgeerT4lO7qy5ntN3YxYHkq9MKZVDEdbiIdBZBHcd2NBiF2Z+wrSBcLn34Ph
         //1ymfnsUAWH8ebCgxHyoOzrNdbNWONDBWOuh3Lrk8VW1k9CvmQoG4aHSLccurGEsbDw
         f8ud+Sjxo0X83KLrh23FnsurU7SREVxv4tXVLpj91/WtFe+t5B0a9gZP8UoymzFAfvF3
         Wi4Y1fv0ich3//VKzH2nNcVVDtsyW/oJW2GlT7HYSFpI48BtsCIavPYfzEr27JXjGtZj
         VFuQSy7vpTQSGXvP86kdtjgFNLPmW9B4J9Ysc5AGD9dMFXjmNjCSAg/bNLuiJS/2pGki
         D4qA==
X-Gm-Message-State: APjAAAXFa1bmoCAH9OyUS48cPgTPzDMAqG8Z16EFTNtarhv2As+/gWOu
        Moewwgr8kGMwurAKftjA0O2dyVhw
X-Google-Smtp-Source: APXvYqyHW2TZnIkBQ5520H6zRK1MlQNllrkvf8yJadgoorRlWgsc8Ux6dyeuO8eCzCunMSNCWCTK/g==
X-Received: by 2002:a24:9947:: with SMTP id a68mr5916807ite.56.1560265770389;
        Tue, 11 Jun 2019 08:09:30 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p25sm4906080iol.48.2019.06.11.08.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:09:30 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF9TnO021776;
        Tue, 11 Jun 2019 15:09:29 GMT
Subject: [PATCH v2 17/19] NFS: Display symbolic status code names in trace
 log
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:09:29 -0400
Message-ID: <20190611150929.2877.39116.stgit@manet.1015granger.net>
In-Reply-To: <20190611150445.2877.8656.stgit@manet.1015granger.net>
References: <20190611150445.2877.8656.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For improved readability, add nfs_show_status() call-sites in the
generic NFS trace points so that the symbolic status code name is
displayed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfstrace.h |   74 +++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index a0d6910..adc30b0 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -83,7 +83,7 @@
 		TP_ARGS(inode, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(unsigned char, type)
@@ -96,7 +96,7 @@
 
 		TP_fast_assign(
 			const struct nfs_inode *nfsi = NFS_I(inode);
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
@@ -108,10 +108,10 @@
 		),
 
 		TP_printk(
-			"error=%d fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"error=%lu (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"type=%u (%s) version=%llu size=%lld "
 			"cache_validity=%lu (%s) nfs_flags=%ld (%s)",
-			__entry->error,
+			__entry->error, nfs_show_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
@@ -219,7 +219,7 @@
 		TP_ARGS(dir, dentry, flags, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(unsigned int, flags)
 			__field(dev_t, dev)
 			__field(u64, dir)
@@ -229,14 +229,14 @@
 		TP_fast_assign(
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->flags = flags;
 			__assign_str(name, dentry->d_name.name);
 		),
 
 		TP_printk(
-			"error=%d flags=%u (%s) name=%02x:%02x:%llu/%s",
-			__entry->error,
+			"error=%lu (%s) flags=%u (%s) name=%02x:%02x:%llu/%s",
+			__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
 			show_lookup_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -323,7 +323,7 @@
 		TP_ARGS(dir, ctx, flags, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(unsigned int, flags)
 			__field(unsigned int, fmode)
 			__field(dev_t, dev)
@@ -332,7 +332,7 @@
 		),
 
 		TP_fast_assign(
-			__entry->error = error;
+			__entry->error = -error;
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
@@ -341,9 +341,9 @@
 		),
 
 		TP_printk(
-			"error=%d flags=%u (%s) fmode=%s "
+			"error=%lu (%s) flags=%u (%s) fmode=%s "
 			"name=%02x:%02x:%llu/%s",
-			__entry->error,
+			__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
 			show_open_flags(__entry->flags),
 			show_fmode_flags(__entry->fmode),
@@ -397,7 +397,7 @@
 		TP_ARGS(dir, dentry, flags, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(unsigned int, flags)
 			__field(dev_t, dev)
 			__field(u64, dir)
@@ -405,7 +405,7 @@
 		),
 
 		TP_fast_assign(
-			__entry->error = error;
+			__entry->error = -error;
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
@@ -413,8 +413,8 @@
 		),
 
 		TP_printk(
-			"error=%d flags=%u (%s) name=%02x:%02x:%llu/%s",
-			__entry->error,
+			"error=%lu (%s) flags=%u (%s) name=%02x:%02x:%llu/%s",
+			__entry->error, nfs_show_status(__entry->error),
 			__entry->flags,
 			show_open_flags(__entry->flags),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -469,7 +469,7 @@
 		TP_ARGS(dir, dentry, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(dev_t, dev)
 			__field(u64, dir)
 			__string(name, dentry->d_name.name)
@@ -478,13 +478,13 @@
 		TP_fast_assign(
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__assign_str(name, dentry->d_name.name);
 		),
 
 		TP_printk(
-			"error=%d name=%02x:%02x:%llu/%s",
-			__entry->error,
+			"error=%lu (%s) name=%02x:%02x:%llu/%s",
+			__entry->error, nfs_show_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -557,7 +557,7 @@
 		TP_ARGS(inode, dir, dentry, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(dev_t, dev)
 			__field(u64, fileid)
 			__field(u64, dir)
@@ -568,13 +568,13 @@
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->dir = NFS_FILEID(dir);
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__assign_str(name, dentry->d_name.name);
 		),
 
 		TP_printk(
-			"error=%d fileid=%02x:%02x:%llu name=%02x:%02x:%llu/%s",
-			__entry->error,
+			"error=%lu (%s) fileid=%02x:%02x:%llu name=%02x:%02x:%llu/%s",
+			__entry->error, nfs_show_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			__entry->fileid,
 			MAJOR(__entry->dev), MINOR(__entry->dev),
@@ -642,7 +642,7 @@
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(u64, old_dir)
 			__string(old_name, old_dentry->d_name.name)
 			__field(u64, new_dir)
@@ -651,17 +651,17 @@
 
 		TP_fast_assign(
 			__entry->dev = old_dir->i_sb->s_dev;
+			__entry->error = -error;
 			__entry->old_dir = NFS_FILEID(old_dir);
 			__entry->new_dir = NFS_FILEID(new_dir);
-			__entry->error = error;
 			__assign_str(old_name, old_dentry->d_name.name);
 			__assign_str(new_name, new_dentry->d_name.name);
 		),
 
 		TP_printk(
-			"error=%d old_name=%02x:%02x:%llu/%s "
+			"error=%lu (%s) old_name=%02x:%02x:%llu/%s "
 			"new_name=%02x:%02x:%llu/%s",
-			__entry->error,
+			__entry->error, nfs_show_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->old_dir,
 			__get_str(old_name),
@@ -697,7 +697,7 @@
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(u64, dir)
 			__dynamic_array(char, name, data->args.name.len + 1)
 		),
@@ -707,15 +707,15 @@
 			size_t len = data->args.name.len;
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
-			__entry->error = error;
+			__entry->error = -error;
 			memcpy(__get_str(name),
 				data->args.name.name, len);
 			__get_str(name)[len] = 0;
 		),
 
 		TP_printk(
-			"error=%d name=%02x:%02x:%llu/%s",
-			__entry->error,
+			"error=%lu (%s) name=%02x:%02x:%llu/%s",
+			__entry->error, nfs_show_status(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
 			__get_str(name)
@@ -974,6 +974,8 @@
 TRACE_DEFINE_ENUM(NFSERR_NOENT);
 TRACE_DEFINE_ENUM(NFSERR_IO);
 TRACE_DEFINE_ENUM(NFSERR_NXIO);
+TRACE_DEFINE_ENUM(ECHILD);
+TRACE_DEFINE_ENUM(NFSERR_EAGAIN);
 TRACE_DEFINE_ENUM(NFSERR_ACCES);
 TRACE_DEFINE_ENUM(NFSERR_EXIST);
 TRACE_DEFINE_ENUM(NFSERR_XDEV);
@@ -985,6 +987,7 @@
 TRACE_DEFINE_ENUM(NFSERR_NOSPC);
 TRACE_DEFINE_ENUM(NFSERR_ROFS);
 TRACE_DEFINE_ENUM(NFSERR_MLINK);
+TRACE_DEFINE_ENUM(NFSERR_OPNOTSUPP);
 TRACE_DEFINE_ENUM(NFSERR_NAMETOOLONG);
 TRACE_DEFINE_ENUM(NFSERR_NOTEMPTY);
 TRACE_DEFINE_ENUM(NFSERR_DQUOT);
@@ -1007,6 +1010,8 @@
 			{ NFSERR_NOENT, "NOENT" }, \
 			{ NFSERR_IO, "IO" }, \
 			{ NFSERR_NXIO, "NXIO" }, \
+			{ ECHILD, "CHILD" }, \
+			{ NFSERR_EAGAIN, "AGAIN" }, \
 			{ NFSERR_ACCES, "ACCES" }, \
 			{ NFSERR_EXIST, "EXIST" }, \
 			{ NFSERR_XDEV, "XDEV" }, \
@@ -1018,6 +1023,7 @@
 			{ NFSERR_NOSPC, "NOSPC" }, \
 			{ NFSERR_ROFS, "ROFS" }, \
 			{ NFSERR_MLINK, "MLINK" }, \
+			{ NFSERR_OPNOTSUPP, "OPNOTSUPP" }, \
 			{ NFSERR_NAMETOOLONG, "NAMETOOLONG" }, \
 			{ NFSERR_NOTEMPTY, "NOTEMPTY" }, \
 			{ NFSERR_DQUOT, "DQUOT" }, \
@@ -1041,7 +1047,7 @@
 		TP_ARGS(error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
@@ -1049,7 +1055,7 @@
 		),
 
 		TP_printk(
-			"error=%d (%s)",
+			"error=%lu (%s)",
 			__entry->error, nfs_show_status(__entry->error)
 		)
 );

