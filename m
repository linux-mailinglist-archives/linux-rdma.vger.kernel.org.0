Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3810CDB636
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2019 20:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406689AbfJQSbr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Oct 2019 14:31:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34056 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbfJQSbr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Oct 2019 14:31:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so5090900qta.1;
        Thu, 17 Oct 2019 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=otlt8/jDB1f+82HmzxFeICdchXOW0YwjEpb2xQOlzog=;
        b=teyzA88Nmc/qPzW8QcRgUp++LmNMi1XLekpPbNmkKyVH6GCS3e0WRDi7umshXC2MoP
         g5vupwI2pO7izVYhMkIAq0HX1VtWLFVQy2SnHuZBV+0XL4C0mqnk6hcWT8XeeLhCoCjB
         tO7ZciQyR0WuHsYUymWO3lDoD5NoR1ug62qdMJOGsYAU3jLrc721ryHGI57AQPSGUTDA
         PuQ/RMD/gURGCV+NtlzLqXtZ2bZnqU6nSkpmlTaP9SkxHJIzPjBfv290KNQJv8uLfXfE
         qviWsy5Mh/GgQpgmURT7UsqyXPE7TruyLUmlk2wZmDoj2UwQIodbMmYBIINGZ4ffRsg2
         jwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=otlt8/jDB1f+82HmzxFeICdchXOW0YwjEpb2xQOlzog=;
        b=muPBPK/cox38W4mslDVQELw7aBUywYf6pgaqDdKssJTDe/hL7l5UMbH5aWHX1+8Xec
         JAIJJLNSMeuztnbQcbyzQEZbFFlBr7PCtH8qZQGbQv8vuZKdrtWKcPB7S2lzCa1cQ5QN
         exRk+aMBUCU1/JBhBMNXgYNn68JtoGWFXw0RxfoCm1hOvYw38YPEyR0dyCgAMuhvEBlL
         lFk95UnRUWj62h1V1FzuNsgHfmWCedJBg4xW1NsupOB1e68MAMJH4WNbG+AicY1kwIFR
         kdkSxEQhV22KVyvhh3ppJHNcQ7UY3RuwTDAshygZntlIoKKQFvIqKoP4LfwXDmYC2NFD
         0Idg==
X-Gm-Message-State: APjAAAU2BT1s7HLmo4HMvunUrAJMgrVH+tOSVpRME6PItc//4oo8buZO
        Eots/cjbl+t3Ncq/oc9fCb7iu2an
X-Google-Smtp-Source: APXvYqzKET+Od9esIlgh2zQ0DH/bucDE6Flue44Yr8cVwUgjGgmn/sONcvLwairkHher84nFZBsYPg==
X-Received: by 2002:ac8:237b:: with SMTP id b56mr5625583qtb.264.1571337105840;
        Thu, 17 Oct 2019 11:31:45 -0700 (PDT)
Received: from oracle-102.nfsv4bat.org ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id d10sm1403350qko.29.2019.10.17.11.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 11:31:45 -0700 (PDT)
Subject: [PATCH v1 5/6] xprtrdma: Refactor rpcrdma_prepare_msg_sges()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Thu, 17 Oct 2019 14:31:44 -0400
Message-ID: <20191017183144.2517.16352.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
References: <20191017182811.2517.25676.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Refactor: Replace spaghetti with code that makes it plain what needs
to be done for each rtype. This makes it easier to add features and
optimizations.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |  263 ++++++++++++++++++++++------------------
 1 file changed, 146 insertions(+), 117 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 53cd2e3..a441dbf 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -589,148 +589,162 @@ static bool rpcrdma_prepare_hdr_sge(struct rpcrdma_xprt *r_xprt,
 {
 	struct rpcrdma_sendctx *sc = req->rl_sendctx;
 	struct rpcrdma_regbuf *rb = req->rl_rdmabuf;
-	struct ib_sge *sge = sc->sc_sges;
+	struct ib_sge *sge = &sc->sc_sges[req->rl_wr.num_sge++];
 
 	if (!rpcrdma_regbuf_dma_map(r_xprt, rb))
-		goto out_regbuf;
+		return false;
 	sge->addr = rdmab_addr(rb);
 	sge->length = len;
 	sge->lkey = rdmab_lkey(rb);
 
 	ib_dma_sync_single_for_device(rdmab_device(rb), sge->addr, sge->length,
 				      DMA_TO_DEVICE);
-	req->rl_wr.num_sge++;
 	return true;
-
-out_regbuf:
-	pr_err("rpcrdma: failed to DMA map a Send buffer\n");
-	return false;
 }
 
-/* Prepare the Send SGEs. The head and tail iovec, and each entry
- * in the page list, gets its own SGE.
+/* The head iovec is straightforward, as it is usually already
+ * DMA-mapped. Sync the content that has changed.
  */
-static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
-				     struct rpcrdma_req *req,
-				     struct xdr_buf *xdr,
-				     enum rpcrdma_chunktype rtype)
+static bool rpcrdma_prepare_head_iov(struct rpcrdma_xprt *r_xprt,
+				     struct rpcrdma_req *req, unsigned int len)
 {
 	struct rpcrdma_sendctx *sc = req->rl_sendctx;
-	unsigned int sge_no, page_base, len, remaining;
+	struct ib_sge *sge = &sc->sc_sges[req->rl_wr.num_sge++];
 	struct rpcrdma_regbuf *rb = req->rl_sendbuf;
-	struct ib_sge *sge = sc->sc_sges;
-	struct page *page, **ppages;
 
-	/* The head iovec is straightforward, as it is already
-	 * DMA-mapped. Sync the content that has changed.
-	 */
 	if (!rpcrdma_regbuf_dma_map(r_xprt, rb))
-		goto out_regbuf;
-	sge_no = 1;
-	sge[sge_no].addr = rdmab_addr(rb);
-	sge[sge_no].length = xdr->head[0].iov_len;
-	sge[sge_no].lkey = rdmab_lkey(rb);
-	ib_dma_sync_single_for_device(rdmab_device(rb), sge[sge_no].addr,
-				      sge[sge_no].length, DMA_TO_DEVICE);
-
-	/* If there is a Read chunk, the page list is being handled
-	 * via explicit RDMA, and thus is skipped here. However, the
-	 * tail iovec may include an XDR pad for the page list, as
-	 * well as additional content, and may not reside in the
-	 * same page as the head iovec.
-	 */
-	if (rtype == rpcrdma_readch) {
-		len = xdr->tail[0].iov_len;
+		return false;
 
-		/* Do not include the tail if it is only an XDR pad */
-		if (len < 4)
-			goto out;
+	sge->addr = rdmab_addr(rb);
+	sge->length = len;
+	sge->lkey = rdmab_lkey(rb);
 
-		page = virt_to_page(xdr->tail[0].iov_base);
-		page_base = offset_in_page(xdr->tail[0].iov_base);
+	ib_dma_sync_single_for_device(rdmab_device(rb), sge->addr, sge->length,
+				      DMA_TO_DEVICE);
+	return true;
+}
 
-		/* If the content in the page list is an odd length,
-		 * xdr_write_pages() has added a pad at the beginning
-		 * of the tail iovec. Force the tail's non-pad content
-		 * to land at the next XDR position in the Send message.
-		 */
-		page_base += len & 3;
-		len -= len & 3;
-		goto map_tail;
-	}
+/* If there is a page list present, DMA map and prepare an
+ * SGE for each page to be sent.
+ */
+static bool rpcrdma_prepare_pagelist(struct rpcrdma_req *req,
+				     struct xdr_buf *xdr)
+{
+	struct rpcrdma_sendctx *sc = req->rl_sendctx;
+	struct rpcrdma_regbuf *rb = req->rl_sendbuf;
+	unsigned int page_base, len, remaining;
+	struct page **ppages;
+	struct ib_sge *sge;
 
-	/* If there is a page list present, temporarily DMA map
-	 * and prepare an SGE for each page to be sent.
-	 */
-	if (xdr->page_len) {
-		ppages = xdr->pages + (xdr->page_base >> PAGE_SHIFT);
-		page_base = offset_in_page(xdr->page_base);
-		remaining = xdr->page_len;
-		while (remaining) {
-			sge_no++;
-			if (sge_no > RPCRDMA_MAX_SEND_SGES - 2)
-				goto out_mapping_overflow;
-
-			len = min_t(u32, PAGE_SIZE - page_base, remaining);
-			sge[sge_no].addr =
-				ib_dma_map_page(rdmab_device(rb), *ppages,
-						page_base, len, DMA_TO_DEVICE);
-			if (ib_dma_mapping_error(rdmab_device(rb),
-						 sge[sge_no].addr))
-				goto out_mapping_err;
-			sge[sge_no].length = len;
-			sge[sge_no].lkey = rdmab_lkey(rb);
-
-			sc->sc_unmap_count++;
-			ppages++;
-			remaining -= len;
-			page_base = 0;
-		}
-	}
+	ppages = xdr->pages + (xdr->page_base >> PAGE_SHIFT);
+	page_base = offset_in_page(xdr->page_base);
+	remaining = xdr->page_len;
+	while (remaining) {
+		sge = &sc->sc_sges[req->rl_wr.num_sge++];
+		len = min_t(unsigned int, PAGE_SIZE - page_base, remaining);
+		sge->addr = ib_dma_map_page(rdmab_device(rb), *ppages,
+					    page_base, len, DMA_TO_DEVICE);
+		if (ib_dma_mapping_error(rdmab_device(rb), sge->addr))
+			goto out_mapping_err;
 
-	/* The tail iovec is not always constructed in the same
-	 * page where the head iovec resides (see, for example,
-	 * gss_wrap_req_priv). To neatly accommodate that case,
-	 * DMA map it separately.
-	 */
-	if (xdr->tail[0].iov_len) {
-		page = virt_to_page(xdr->tail[0].iov_base);
-		page_base = offset_in_page(xdr->tail[0].iov_base);
-		len = xdr->tail[0].iov_len;
+		sge->length = len;
+		sge->lkey = rdmab_lkey(rb);
 
-map_tail:
-		sge_no++;
-		sge[sge_no].addr =
-			ib_dma_map_page(rdmab_device(rb), page, page_base, len,
-					DMA_TO_DEVICE);
-		if (ib_dma_mapping_error(rdmab_device(rb), sge[sge_no].addr))
-			goto out_mapping_err;
-		sge[sge_no].length = len;
-		sge[sge_no].lkey = rdmab_lkey(rb);
 		sc->sc_unmap_count++;
+		ppages++;
+		remaining -= len;
+		page_base = 0;
 	}
 
-out:
-	req->rl_wr.num_sge += sge_no;
-	if (sc->sc_unmap_count)
-		kref_get(&req->rl_kref);
 	return true;
 
-out_regbuf:
-	pr_err("rpcrdma: failed to DMA map a Send buffer\n");
+out_mapping_err:
+	trace_xprtrdma_dma_maperr(sge->addr);
 	return false;
+}
 
-out_mapping_overflow:
-	rpcrdma_sendctx_unmap(sc);
-	pr_err("rpcrdma: too many Send SGEs (%u)\n", sge_no);
-	return false;
+/* The tail iovec may include an XDR pad for the page list,
+ * as well as additional content, and may not reside in the
+ * same page as the head iovec.
+ */
+static bool rpcrdma_prepare_tail_iov(struct rpcrdma_req *req,
+				     struct xdr_buf *xdr,
+				     unsigned int page_base, unsigned int len)
+{
+	struct rpcrdma_sendctx *sc = req->rl_sendctx;
+	struct ib_sge *sge = &sc->sc_sges[req->rl_wr.num_sge++];
+	struct rpcrdma_regbuf *rb = req->rl_sendbuf;
+	struct page *page = virt_to_page(xdr->tail[0].iov_base);
+
+	sge->addr = ib_dma_map_page(rdmab_device(rb), page, page_base, len,
+				    DMA_TO_DEVICE);
+	if (ib_dma_mapping_error(rdmab_device(rb), sge->addr))
+		goto out_mapping_err;
+
+	sge->length = len;
+	sge->lkey = rdmab_lkey(rb);
+	++sc->sc_unmap_count;
+	return true;
 
 out_mapping_err:
-	rpcrdma_sendctx_unmap(sc);
-	trace_xprtrdma_dma_maperr(sge[sge_no].addr);
+	trace_xprtrdma_dma_maperr(sge->addr);
 	return false;
 }
 
+static bool rpcrdma_prepare_noch_mapped(struct rpcrdma_xprt *r_xprt,
+					struct rpcrdma_req *req,
+					struct xdr_buf *xdr)
+{
+	struct kvec *tail = &xdr->tail[0];
+
+	if (!rpcrdma_prepare_head_iov(r_xprt, req, xdr->head[0].iov_len))
+		return false;
+	if (xdr->page_len)
+		if (!rpcrdma_prepare_pagelist(req, xdr))
+			return false;
+	if (tail->iov_len)
+		if (!rpcrdma_prepare_tail_iov(req, xdr,
+					      offset_in_page(tail->iov_base),
+					      tail->iov_len))
+			return false;
+
+	if (req->rl_sendctx->sc_unmap_count)
+		kref_get(&req->rl_kref);
+	return true;
+}
+
+static bool rpcrdma_prepare_readch(struct rpcrdma_xprt *r_xprt,
+				   struct rpcrdma_req *req,
+				   struct xdr_buf *xdr)
+{
+	if (!rpcrdma_prepare_head_iov(r_xprt, req, xdr->head[0].iov_len))
+		return false;
+
+	/* If there is a Read chunk, the page list is being handled
+	 * via explicit RDMA, and thus is skipped here.
+	 */
+
+	/* Do not include the tail if it is only an XDR pad */
+	if (xdr->tail[0].iov_len > 3) {
+		unsigned int page_base, len;
+
+		/* If the content in the page list is an odd length,
+		 * xdr_write_pages() adds a pad at the beginning of
+		 * the tail iovec. Force the tail's non-pad content to
+		 * land at the next XDR position in the Send message.
+		 */
+		page_base = offset_in_page(xdr->tail[0].iov_base);
+		len = xdr->tail[0].iov_len;
+		page_base += len & 3;
+		len -= len & 3;
+		if (!rpcrdma_prepare_tail_iov(req, xdr, page_base, len))
+			return false;
+		kref_get(&req->rl_kref);
+	}
+
+	return true;
+}
+
 /**
  * rpcrdma_prepare_send_sges - Construct SGEs for a Send WR
  * @r_xprt: controlling transport
@@ -741,17 +755,17 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
  *
  * Returns 0 on success; otherwise a negative errno is returned.
  */
-int
-rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
-			  struct rpcrdma_req *req, u32 hdrlen,
-			  struct xdr_buf *xdr, enum rpcrdma_chunktype rtype)
+inline int rpcrdma_prepare_send_sges(struct rpcrdma_xprt *r_xprt,
+				     struct rpcrdma_req *req, u32 hdrlen,
+				     struct xdr_buf *xdr,
+				     enum rpcrdma_chunktype rtype)
 {
 	int ret;
 
 	ret = -EAGAIN;
 	req->rl_sendctx = rpcrdma_sendctx_get_locked(r_xprt);
 	if (!req->rl_sendctx)
-		goto err;
+		goto out_nosc;
 	req->rl_sendctx->sc_unmap_count = 0;
 	req->rl_sendctx->sc_req = req;
 	kref_init(&req->rl_kref);
@@ -762,13 +776,28 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 
 	ret = -EIO;
 	if (!rpcrdma_prepare_hdr_sge(r_xprt, req, hdrlen))
-		goto err;
-	if (rtype != rpcrdma_areadch)
-		if (!rpcrdma_prepare_msg_sges(r_xprt, req, xdr, rtype))
-			goto err;
+		goto out_unmap;
+
+	switch (rtype) {
+	case rpcrdma_noch:
+		if (!rpcrdma_prepare_noch_mapped(r_xprt, req, xdr))
+			goto out_unmap;
+		break;
+	case rpcrdma_readch:
+		if (!rpcrdma_prepare_readch(r_xprt, req, xdr))
+			goto out_unmap;
+		break;
+	case rpcrdma_areadch:
+		break;
+	default:
+		goto out_unmap;
+	}
+
 	return 0;
 
-err:
+out_unmap:
+	rpcrdma_sendctx_unmap(req->rl_sendctx);
+out_nosc:
 	trace_xprtrdma_prepsend_failed(&req->rl_slot, ret);
 	return ret;
 }

