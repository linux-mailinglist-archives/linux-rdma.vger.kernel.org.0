Return-Path: <linux-rdma+bounces-13579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453FAB93017
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BAC44648D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 19:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DE42F39DE;
	Mon, 22 Sep 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="se+JD252"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7548274B2F;
	Mon, 22 Sep 2025 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570119; cv=none; b=kyW9pXZSmqR328zdTsbW8DAMPUSO5qLJ0hiJLiKTYOuFLZHW6S/vTLnZMffV46BYjonM67FtzxMU1ZPz68Cjo4vSY5lR8SnL6LZDhZeX95Jl5tZZMDyUGGhhH/Jc7KsVhIn6QroskWDHb9pXe+EPioPyAyB9ZkWPnRdTxluGa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570119; c=relaxed/simple;
	bh=cjvp6MWRdurf8sD2jGxuaOrs7PEWl8iHYmrMe+QhrSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n40UEdw0Hh0Gw8NL6WuDnfcQhaPdJ96n8WZs7fOlkxi8LGUT3g8p4oaSkfTnPW7kqtH3OswIqKkMWrlmzN40ZqRT9dlnCjgljbGFHcGKd9pqE12NbD01aCbFMQKNp4FmYNXT33xqt1jl6fMX0Fmf8BbY3f85/UKpQJX382xzS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=se+JD252; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A855C4CEF0;
	Mon, 22 Sep 2025 19:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570118;
	bh=cjvp6MWRdurf8sD2jGxuaOrs7PEWl8iHYmrMe+QhrSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=se+JD252WltjYIsDofFtdqWh+xpqgWQG4qpXlHa+cI9xpVTth9MlP26m53D1ZRY62
	 +Eszl3XeinFDlvM0DuoM/GLAAWT4IopycUL02G97/26ZM1o/J+aAkpM17NJhDwdR5v
	 RT+UckXA4V30ChBA5kBlvoOAdHGUWeKmTU19rR34=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-rdma@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 012/149] smb: server: let smb_direct_writev() respect SMB_DIRECT_MAX_SEND_SGES
Date: Mon, 22 Sep 2025 21:28:32 +0200
Message-ID: <20250922192413.195471542@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit d162694037215fe25f1487999c58d70df809a2fd ]

We should not use more sges for ib_post_send() than we told the rdma
device in rdma_create_qp()!

Otherwise ib_post_send() will return -EINVAL, so we disconnect the
connection. Or with the current siw.ko we'll get 0 from ib_post_send(),
but will never ever get a completion for the request. I've already sent a
fix for siw.ko...

So we need to make sure smb_direct_writev() limits the number of vectors
we pass to individual smb_direct_post_send_data() calls, so that we
don't go over the queue pair limits.

Commit 621433b7e25d ("ksmbd: smbd: relax the count of sges required")
was very strange and I guess only needed because
SMB_DIRECT_MAX_SEND_SGES was 8 at that time. It basically removed the
check that the rdma device is able to handle the number of sges we try
to use.

While the real problem was added by commit ddbdc861e37c ("ksmbd: smbd:
introduce read/write credits for RDMA read/write") as it used the
minumun of device->attrs.max_send_sge and device->attrs.max_sge_rd, with
the problem that device->attrs.max_sge_rd is always 1 for iWarp. And
that limitation should only apply to RDMA Read operations. For now we
keep that limitation for RDMA Write operations too, fixing that is a
task for another day as it's not really required a bug fix.

Commit 2b4eeeaa9061 ("ksmbd: decrease the number of SMB3 smbdirect
server SGEs") lowered SMB_DIRECT_MAX_SEND_SGES to 6, which is also used
by our client code. And that client code enforces
device->attrs.max_send_sge >= 6 since commit d2e81f92e5b7 ("Decrease the
number of SMB3 smbdirect client SGEs") and (briefly looking) only the
i40w driver provides only 3, see I40IW_MAX_WQ_FRAGMENT_COUNT. But
currently we'd require 4 anyway, so that would not work anyway, but now
it fails early.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: linux-rdma@vger.kernel.org
Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Fixes: ddbdc861e37c ("ksmbd: smbd: introduce read/write credits for RDMA read/write")
Fixes: 621433b7e25d ("ksmbd: smbd: relax the count of sges required")
Fixes: 2b4eeeaa9061 ("ksmbd: decrease the number of SMB3 smbdirect server SGEs")
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/transport_rdma.c | 157 ++++++++++++++++++++++-----------
 1 file changed, 107 insertions(+), 50 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 5466aa8c39b1c..cc4322bfa1d61 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1209,78 +1209,130 @@ static int smb_direct_writev(struct ksmbd_transport *t,
 			     bool need_invalidate, unsigned int remote_key)
 {
 	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
-	int remaining_data_length;
-	int start, i, j;
-	int max_iov_size = st->max_send_size -
+	size_t remaining_data_length;
+	size_t iov_idx;
+	size_t iov_ofs;
+	size_t max_iov_size = st->max_send_size -
 			sizeof(struct smb_direct_data_transfer);
 	int ret;
-	struct kvec vec;
 	struct smb_direct_send_ctx send_ctx;
+	int error = 0;
 
 	if (st->status != SMB_DIRECT_CS_CONNECTED)
 		return -ENOTCONN;
 
 	//FIXME: skip RFC1002 header..
+	if (WARN_ON_ONCE(niovs <= 1 || iov[0].iov_len != 4))
+		return -EINVAL;
 	buflen -= 4;
+	iov_idx = 1;
+	iov_ofs = 0;
 
 	remaining_data_length = buflen;
 	ksmbd_debug(RDMA, "Sending smb (RDMA): smb_len=%u\n", buflen);
 
 	smb_direct_send_ctx_init(st, &send_ctx, need_invalidate, remote_key);
-	start = i = 1;
-	buflen = 0;
-	while (true) {
-		buflen += iov[i].iov_len;
-		if (buflen > max_iov_size) {
-			if (i > start) {
-				remaining_data_length -=
-					(buflen - iov[i].iov_len);
-				ret = smb_direct_post_send_data(st, &send_ctx,
-								&iov[start], i - start,
-								remaining_data_length);
-				if (ret)
+	while (remaining_data_length) {
+		struct kvec vecs[SMB_DIRECT_MAX_SEND_SGES - 1]; /* minus smbdirect hdr */
+		size_t possible_bytes = max_iov_size;
+		size_t possible_vecs;
+		size_t bytes = 0;
+		size_t nvecs = 0;
+
+		/*
+		 * For the last message remaining_data_length should be
+		 * have been 0 already!
+		 */
+		if (WARN_ON_ONCE(iov_idx >= niovs)) {
+			error = -EINVAL;
+			goto done;
+		}
+
+		/*
+		 * We have 2 factors which limit the arguments we pass
+		 * to smb_direct_post_send_data():
+		 *
+		 * 1. The number of supported sges for the send,
+		 *    while one is reserved for the smbdirect header.
+		 *    And we currently need one SGE per page.
+		 * 2. The number of negotiated payload bytes per send.
+		 */
+		possible_vecs = min_t(size_t, ARRAY_SIZE(vecs), niovs - iov_idx);
+
+		while (iov_idx < niovs && possible_vecs && possible_bytes) {
+			struct kvec *v = &vecs[nvecs];
+			int page_count;
+
+			v->iov_base = ((u8 *)iov[iov_idx].iov_base) + iov_ofs;
+			v->iov_len = min_t(size_t,
+					   iov[iov_idx].iov_len - iov_ofs,
+					   possible_bytes);
+			page_count = get_buf_page_count(v->iov_base, v->iov_len);
+			if (page_count > possible_vecs) {
+				/*
+				 * If the number of pages in the buffer
+				 * is to much (because we currently require
+				 * one SGE per page), we need to limit the
+				 * length.
+				 *
+				 * We know possible_vecs is at least 1,
+				 * so we always keep the first page.
+				 *
+				 * We need to calculate the number extra
+				 * pages (epages) we can also keep.
+				 *
+				 * We calculate the number of bytes in the
+				 * first page (fplen), this should never be
+				 * larger than v->iov_len because page_count is
+				 * at least 2, but adding a limitation feels
+				 * better.
+				 *
+				 * Then we calculate the number of bytes (elen)
+				 * we can keep for the extra pages.
+				 */
+				size_t epages = possible_vecs - 1;
+				size_t fpofs = offset_in_page(v->iov_base);
+				size_t fplen = min_t(size_t, PAGE_SIZE - fpofs, v->iov_len);
+				size_t elen = min_t(size_t, v->iov_len - fplen, epages*PAGE_SIZE);
+
+				v->iov_len = fplen + elen;
+				page_count = get_buf_page_count(v->iov_base, v->iov_len);
+				if (WARN_ON_ONCE(page_count > possible_vecs)) {
+					/*
+					 * Something went wrong in the above
+					 * logic...
+					 */
+					error = -EINVAL;
 					goto done;
-			} else {
-				/* iov[start] is too big, break it */
-				int nvec  = (buflen + max_iov_size - 1) /
-						max_iov_size;
-
-				for (j = 0; j < nvec; j++) {
-					vec.iov_base =
-						(char *)iov[start].iov_base +
-						j * max_iov_size;
-					vec.iov_len =
-						min_t(int, max_iov_size,
-						      buflen - max_iov_size * j);
-					remaining_data_length -= vec.iov_len;
-					ret = smb_direct_post_send_data(st, &send_ctx, &vec, 1,
-									remaining_data_length);
-					if (ret)
-						goto done;
 				}
-				i++;
-				if (i == niovs)
-					break;
 			}
-			start = i;
-			buflen = 0;
-		} else {
-			i++;
-			if (i == niovs) {
-				/* send out all remaining vecs */
-				remaining_data_length -= buflen;
-				ret = smb_direct_post_send_data(st, &send_ctx,
-								&iov[start], i - start,
-								remaining_data_length);
-				if (ret)
-					goto done;
-				break;
+			possible_vecs -= page_count;
+			nvecs += 1;
+			possible_bytes -= v->iov_len;
+			bytes += v->iov_len;
+
+			iov_ofs += v->iov_len;
+			if (iov_ofs >= iov[iov_idx].iov_len) {
+				iov_idx += 1;
+				iov_ofs = 0;
 			}
 		}
+
+		remaining_data_length -= bytes;
+
+		ret = smb_direct_post_send_data(st, &send_ctx,
+						vecs, nvecs,
+						remaining_data_length);
+		if (unlikely(ret)) {
+			error = ret;
+			goto done;
+		}
 	}
 
 done:
 	ret = smb_direct_flush_send_list(st, &send_ctx, true);
+	if (unlikely(!ret && error))
+		ret = error;
 
 	/*
 	 * As an optimization, we don't wait for individual I/O to finish
@@ -1744,6 +1796,11 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
 		return -EINVAL;
 	}
 
+	if (device->attrs.max_send_sge < SMB_DIRECT_MAX_SEND_SGES) {
+		pr_err("warning: device max_send_sge = %d too small\n",
+		       device->attrs.max_send_sge);
+		return -EINVAL;
+	}
 	if (device->attrs.max_recv_sge < SMB_DIRECT_MAX_RECV_SGES) {
 		pr_err("warning: device max_recv_sge = %d too small\n",
 		       device->attrs.max_recv_sge);
@@ -1767,7 +1824,7 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
 
 	cap->max_send_wr = max_send_wrs;
 	cap->max_recv_wr = t->recv_credit_max;
-	cap->max_send_sge = max_sge_per_wr;
+	cap->max_send_sge = SMB_DIRECT_MAX_SEND_SGES;
 	cap->max_recv_sge = SMB_DIRECT_MAX_RECV_SGES;
 	cap->max_inline_data = 0;
 	cap->max_rdma_ctxs = t->max_rw_credits;
-- 
2.51.0




