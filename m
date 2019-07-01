Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9AA54874D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2019 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbfFQPc5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jun 2019 11:32:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46397 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfFQPc5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jun 2019 11:32:57 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so21994491iol.13;
        Mon, 17 Jun 2019 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bO7pl8iwwTVVRYmb6oOzDMSb1cD+0aV0GdDMju9igDw=;
        b=lEVQHRvAWmqUGL2T3rewO1PX9h3Gi7dooS00Z0Bfv+lIeL/fHwkJtiLP8FOOL81Urg
         fPbX9G1yp50K1x6AFVFG6SMJIQwtnu3knfSpUj7xSb+9lacol2RKNk3aKuC9OVFAH0vd
         Ntk22CUylbw8Jixtzwzu55bRVonQ/qW+tqrLrRGeu3vewXDH+pWkx4e+yJHrCPlKuThq
         16dbp4Oa9Us14O6ZfVxNnZvfRTI/zaXXLTPhNdh4d1X17olmvxy0SApiNaQbqheUAV0X
         RBZufBMSXEQIRBmEAKvuKDUL/8HUOG0Ju5mg3iotyIOA3k/mbENUgWZglxF3tLsd60Pa
         83NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=bO7pl8iwwTVVRYmb6oOzDMSb1cD+0aV0GdDMju9igDw=;
        b=IXk69C5jarRtrMGiem9JaCh2cSoNjHFJjtEpRHuP+3ja8G7mjHoGC9x+veR/pAVmi6
         tmUQYMWBoUvlI2Z6Ta5QMzyVZBgnZl2FdtcHd6WHbSLOETMJnqg255cQ5DohUkUetYQe
         Jjk58BF38lgbs9jJxA5d6NOPuPpL9czQsd0T9otG4nD7yzGDi9gFFeWVdO45vMOEnOhI
         sGeAtcP8/1WPtGyvs1Uk30UlMc7I+VugV8OZWUiByNbGnn/cDsYQYf79Ka2r1Q5uJPcm
         Ldrord/uijR+tFr8WDjAlQM88pZpDBO6PbqUABZ5PFfNKuigDpMQAxl6ckH9k20T7+dL
         CMqA==
X-Gm-Message-State: APjAAAXU/v7GRPFzMp+pqxY7tvjQOAinO0JeFXUxYz0TgF4D9H2/jUB8
        8zw6Sktby1VnlpXB94915kvA6wh1
X-Google-Smtp-Source: APXvYqxRDPg7JDGGQrDd2MtsMgD52Oq9OwfRJ2qkqLediaZDOglAXfbmQapI+mHuN+MscNU7xQKx4Q==
X-Received: by 2002:a6b:5812:: with SMTP id m18mr4652339iob.13.1560785576289;
        Mon, 17 Jun 2019 08:32:56 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id o7sm10226161ioo.81.2019.06.17.08.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:32:55 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFWt8J031233;
        Mon, 17 Jun 2019 15:32:55 GMT
Subject: [PATCH v3 16/19] NFS: Fix show_nfs_errors macros again
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:32:55 -0400
Message-ID: <20190617153255.12090.52707.stgit@manet.1015granger.net>
In-Reply-To: <20190617152657.12090.11389.stgit@manet.1015granger.net>
References: <20190617152657.12090.11389.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I noticed that NFS status values stopped working again.

trace_print_symbols_seq() takes an unsigned long. Passing a negative
errno or negative NFSERR value just confuses it, and since we're
using C macros here and not static inline functions, all bets are
off due to implicit type conversion.

Straight-line the calling conventions so that error codes are stored
in the trace record as positive values in an unsigned long field,
mapped to symbolic as an unsigned long, and displayed as a negative
value, to continue to enable grepping on "error=-".

It's often the case that an error value that is positive is a byte
count but when it's negative, it's an error (e.g. nfs4_write). Fix
those cases so that the value that is eventually stored in the
error field is a positive NFS status or errno, or zero.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4trace.h |  164 ++++++++++++++++++++++++++--------------------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 6beb1f2..9a39fd5 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -156,7 +156,7 @@
 TRACE_DEFINE_ENUM(NFS4ERR_XDEV);
 
 #define show_nfsv4_errors(error) \
-	__print_symbolic(-(error), \
+	__print_symbolic(error, \
 		{ NFS4_OK, "OK" }, \
 		/* Mapped by nfs4_stat_to_errno() */ \
 		{ EPERM, "EPERM" }, \
@@ -348,7 +348,7 @@
 
 		TP_STRUCT__entry(
 			__string(dstaddr, clp->cl_hostname)
-			__field(int, error)
+			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
@@ -357,8 +357,8 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) dstaddr=%s",
-			__entry->error,
+			"error=%ld (%s) dstaddr=%s",
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			__get_str(dstaddr)
 		)
@@ -420,7 +420,7 @@
 			__field(unsigned int, highest_slotid)
 			__field(unsigned int, target_highest_slotid)
 			__field(unsigned int, status_flags)
-			__field(int, error)
+			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
@@ -435,10 +435,10 @@
 			__entry->error = res->sr_status;
 		),
 		TP_printk(
-			"error=%d (%s) session=0x%08x slot_nr=%u seq_nr=%u "
+			"error=%ld (%s) session=0x%08x slot_nr=%u seq_nr=%u "
 			"highest_slotid=%u target_highest_slotid=%u "
 			"status_flags=%u (%s)",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			__entry->session,
 			__entry->slot_nr,
@@ -467,7 +467,7 @@
 			__field(unsigned int, seq_nr)
 			__field(unsigned int, highest_slotid)
 			__field(unsigned int, cachethis)
-			__field(int, error)
+			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
@@ -476,13 +476,13 @@
 			__entry->seq_nr = args->csa_sequenceid;
 			__entry->highest_slotid = args->csa_highestslotid;
 			__entry->cachethis = args->csa_cachethis;
-			__entry->error = -be32_to_cpu(status);
+			__entry->error = be32_to_cpu(status);
 		),
 
 		TP_printk(
-			"error=%d (%s) session=0x%08x slot_nr=%u seq_nr=%u "
+			"error=%ld (%s) session=0x%08x slot_nr=%u seq_nr=%u "
 			"highest_slotid=%u",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			__entry->session,
 			__entry->slot_nr,
@@ -504,7 +504,7 @@
 			__field(unsigned int, seq_nr)
 			__field(unsigned int, highest_slotid)
 			__field(unsigned int, cachethis)
-			__field(int, error)
+			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
@@ -513,13 +513,13 @@
 			__entry->seq_nr = args->csa_sequenceid;
 			__entry->highest_slotid = args->csa_highestslotid;
 			__entry->cachethis = args->csa_cachethis;
-			__entry->error = -be32_to_cpu(status);
+			__entry->error = be32_to_cpu(status);
 		),
 
 		TP_printk(
-			"error=%d (%s) session=0x%08x slot_nr=%u seq_nr=%u "
+			"error=%ld (%s) session=0x%08x slot_nr=%u seq_nr=%u "
 			"highest_slotid=%u",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			__entry->session,
 			__entry->slot_nr,
@@ -572,18 +572,18 @@
 
 		TP_STRUCT__entry(
 			__field(u32, op)
-			__field(int, error)
+			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
 			__entry->op = op;
-			__entry->error = -error;
+			__entry->error = error;
 		),
 
 		TP_printk(
-			"operation %d: nfs status %d (%s)",
-			__entry->op,
-			__entry->error, show_nfsv4_errors(__entry->error)
+			"error=%ld (%s) operation %d:",
+			-__entry->error, show_nfsv4_errors(__entry->error),
+			__entry->op
 		)
 );
 
@@ -597,7 +597,7 @@
 		TP_ARGS(ctx, flags, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(unsigned int, flags)
 			__field(unsigned int, fmode)
 			__field(dev_t, dev)
@@ -615,7 +615,7 @@
 			const struct nfs4_state *state = ctx->state;
 			const struct inode *inode = NULL;
 
-			__entry->error = error;
+			__entry->error = -error;
 			__entry->flags = flags;
 			__entry->fmode = (__force unsigned int)ctx->mode;
 			__entry->dev = ctx->dentry->d_sb->s_dev;
@@ -647,11 +647,11 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) flags=%d (%s) fmode=%s "
+			"error=%ld (%s) flags=%d (%s) fmode=%s "
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"name=%02x:%02x:%llu/%s stateid=%d:0x%08x "
 			"openstateid=%d:0x%08x",
-			 __entry->error,
+			 -__entry->error,
 			 show_nfsv4_errors(__entry->error),
 			 __entry->flags,
 			 show_open_flags(__entry->flags),
@@ -733,7 +733,7 @@
 			__field(u32, fhandle)
 			__field(u64, fileid)
 			__field(unsigned int, fmode)
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
 		),
@@ -753,9 +753,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) fmode=%s fileid=%02x:%02x:%llu "
+			"error=%ld (%s) fmode=%s fileid=%02x:%02x:%llu "
 			"fhandle=0x%08x openstateid=%d:0x%08x",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			__entry->fmode ?  show_fmode_flags(__entry->fmode) :
 					  "closed",
@@ -795,7 +795,7 @@
 		TP_ARGS(request, state, cmd, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(int, cmd)
 			__field(char, type)
 			__field(loff_t, start)
@@ -825,10 +825,10 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) cmd=%s:%s range=%lld:%lld "
+			"error=%ld (%s) cmd=%s:%s range=%lld:%lld "
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			show_lock_cmd(__entry->cmd),
 			show_lock_type(__entry->type),
@@ -865,7 +865,7 @@
 		TP_ARGS(request, state, lockstateid, cmd, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(int, cmd)
 			__field(char, type)
 			__field(loff_t, start)
@@ -901,10 +901,10 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) cmd=%s:%s range=%lld:%lld "
+			"error=%ld (%s) cmd=%s:%s range=%lld:%lld "
 			"fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x lockstateid=%d:0x%08x",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			show_lock_cmd(__entry->cmd),
 			show_lock_type(__entry->type),
@@ -970,7 +970,7 @@
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
 			__field(u32, fhandle)
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
 		),
@@ -986,9 +986,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) dev=%02x:%02x fhandle=0x%08x "
+			"error=%ld (%s) dev=%02x:%02x fhandle=0x%08x "
 			"stateid=%d:0x%08x",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			__entry->fhandle,
@@ -1007,7 +1007,7 @@
 		TP_ARGS(state, lsp, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
@@ -1029,9 +1029,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -1064,7 +1064,7 @@
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(u64, dir)
 			__string(name, name->name)
 		),
@@ -1072,13 +1072,13 @@
 		TP_fast_assign(
 			__entry->dev = dir->i_sb->s_dev;
 			__entry->dir = NFS_FILEID(dir);
-			__entry->error = error;
+			__entry->error = -error;
 			__assign_str(name, name->name);
 		),
 
 		TP_printk(
-			"error=%d (%s) name=%02x:%02x:%llu/%s",
-			__entry->error,
+			"error=%ld (%s) name=%02x:%02x:%llu/%s",
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->dir,
@@ -1114,7 +1114,7 @@
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
 			__field(u64, ino)
-			__field(int, error)
+			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
@@ -1124,8 +1124,8 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) inode=%02x:%02x:%llu",
-			__entry->error,
+			"error=%ld (%s) inode=%02x:%02x:%llu",
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->ino
@@ -1145,7 +1145,7 @@
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(u64, olddir)
 			__string(oldname, oldname->name)
 			__field(u64, newdir)
@@ -1162,9 +1162,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) oldname=%02x:%02x:%llu/%s "
+			"error=%ld (%s) oldname=%02x:%02x:%llu/%s "
 			"newname=%02x:%02x:%llu/%s",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->olddir,
@@ -1187,19 +1187,19 @@
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
-			__field(int, error)
+			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
 			__entry->dev = inode->i_sb->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 		),
 
 		TP_printk(
-			"error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x",
-			__entry->error,
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x",
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -1238,7 +1238,7 @@
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
 		),
@@ -1255,9 +1255,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -1295,7 +1295,7 @@
 			__field(u32, fhandle)
 			__field(u64, fileid)
 			__field(unsigned int, valid)
-			__field(int, error)
+			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
@@ -1307,9 +1307,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"valid=%s",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -1342,7 +1342,7 @@
 		TP_ARGS(clp, fhandle, inode, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
@@ -1363,9 +1363,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"dstaddr=%s",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -1397,7 +1397,7 @@
 		TP_ARGS(clp, fhandle, inode, stateid, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(dev_t, dev)
 			__field(u32, fhandle)
 			__field(u64, fileid)
@@ -1424,9 +1424,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"stateid=%d:0x%08x dstaddr=%s",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -1460,7 +1460,7 @@
 		TP_ARGS(name, len, id, error),
 
 		TP_STRUCT__entry(
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(u32, id)
 			__dynamic_array(char, name, len > 0 ? len + 1 : 1)
 		),
@@ -1475,8 +1475,8 @@
 		),
 
 		TP_printk(
-			"error=%d id=%u name=%s",
-			__entry->error,
+			"error=%ld (%s) id=%u name=%s",
+			-__entry->error, show_nfsv4_errors(__entry->error),
 			__entry->id,
 			__get_str(name)
 		)
@@ -1509,7 +1509,7 @@
 			__field(u64, fileid)
 			__field(loff_t, offset)
 			__field(size_t, count)
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
 		),
@@ -1523,7 +1523,7 @@
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->offset = hdr->args.offset;
 			__entry->count = hdr->args.count;
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->stateid_seq =
 				be32_to_cpu(state->stateid.seqid);
 			__entry->stateid_hash =
@@ -1531,9 +1531,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"offset=%lld count=%zu stateid=%d:0x%08x",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -1569,7 +1569,7 @@
 			__field(u64, fileid)
 			__field(loff_t, offset)
 			__field(size_t, count)
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
 		),
@@ -1583,7 +1583,7 @@
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->offset = hdr->args.offset;
 			__entry->count = hdr->args.count;
-			__entry->error = error;
+			__entry->error = error < 0 ? -error : 0;
 			__entry->stateid_seq =
 				be32_to_cpu(state->stateid.seqid);
 			__entry->stateid_hash =
@@ -1591,9 +1591,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"offset=%lld count=%zu stateid=%d:0x%08x",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -1630,7 +1630,7 @@
 			__field(u64, fileid)
 			__field(loff_t, offset)
 			__field(size_t, count)
-			__field(int, error)
+			__field(unsigned long, error)
 		),
 
 		TP_fast_assign(
@@ -1644,9 +1644,9 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"offset=%lld count=%zu",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
@@ -1694,7 +1694,7 @@
 			__field(u32, iomode)
 			__field(u64, offset)
 			__field(u64, count)
-			__field(int, error)
+			__field(unsigned long, error)
 			__field(int, stateid_seq)
 			__field(u32, stateid_hash)
 			__field(int, layoutstateid_seq)
@@ -1727,10 +1727,10 @@
 		),
 
 		TP_printk(
-			"error=%d (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
 			"iomode=%s offset=%llu count=%llu stateid=%d:0x%08x "
 			"layoutstateid=%d:0x%08x",
-			__entry->error,
+			-__entry->error,
 			show_nfsv4_errors(__entry->error),
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,

