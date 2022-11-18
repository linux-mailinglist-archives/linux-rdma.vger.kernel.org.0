Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D53362FFA3
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 22:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiKRV7I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 16:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRV7H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 16:59:07 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE4D7AF49
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 13:58:54 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v17so5728281plo.1
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 13:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGuhGDCtJh7U/PfIpJklIgL+pxK6g8kJvzZK0so7MNM=;
        b=Tt178UvIpw6m9LNmpSg90J7p2S59YIhzSlqVlFy8TPxxLPdEVF8TktBqmiVuBCzXn4
         FlyL8ygogW1faiejozMX3wwZ15yNYIP1u5l7rjEn6BsKKKdxCcYIMbERkbSedPPS+3Re
         vBfMkb5LcpP57zzpApKsef+E0pgOLb6K2+cC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGuhGDCtJh7U/PfIpJklIgL+pxK6g8kJvzZK0so7MNM=;
        b=Hkm7dekWP8xyRw6y4a62AVrbSzpWmnRa/bXtzn2eq5iM8yfqFzPBjdQ+/7gMfxGolY
         HvEN0zwVH9N1JlHqYxCe5VhkTRQDGZ3rKtmtYDk6WEybFhs3sshWE9zEVPtFv+25wC4q
         DLHs69AulF3PNxufVdWkLVLgZWZ8aRcyoUCAH1gZds1PMOTEHEZaZ78EiudHXymel+SM
         KZ+E082DEPfF6qpPYttsEqhoO/wJ5Q1t0lmMuVfYzoEaokMXlqLaOkIP3fX7MaRcB4Vt
         /FY9qBeLh+oBPhqixMMlh4xUlfyThNqzztilETc3oTArX2k7jNByLhpuFffb0rFCF6BA
         fDxg==
X-Gm-Message-State: ANoB5pl/bBUeav5wo0y+S9XZBqSYUeYZ7rQu0na/feMzexqGMPjCkqi3
        ZCz7YUnpQymSQz0OQdYcV68YiQ==
X-Google-Smtp-Source: AA0mqf7aJHqBHL9c0HthlRZPgI19ioUmFKZkzDkF6JLL+yJtKD8rBUue0bKxJy3kiHh70ZgOcC1a3w==
X-Received: by 2002:a17:902:f80d:b0:186:5d84:604e with SMTP id ix13-20020a170902f80d00b001865d84604emr1389916plb.85.1668808734108;
        Fri, 18 Nov 2022 13:58:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902654500b00168dadc7354sm4264628pln.78.2022.11.18.13.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 13:58:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, cgel.zte@gmail.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] IB/hfi1: Replace 1-element array with singleton
Date:   Fri, 18 Nov 2022 13:58:51 -0800
Message-Id: <20221118215847.never.416-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4229; h=from:subject:message-id; bh=CITklIdZXjvaOkKNHxlyvz5+xGxonN3wFS+DWEK5P8E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjeAAaOgw7tNqzwfhacH7ZWIUVsgnuwKFfdUzSYs3A xrFYbrCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3gAGgAKCRCJcvTf3G3AJgK9D/ 0enMJo74GYWgMGdD5E2HmAsUoVb9zcqcEQ6DNgNUK4vKfo++zqy4dmFhjLvH1SjXvnY9234fN2g+y7 C6O+5SPDFxzvDK2+gZMsZqVSKLy6Sew6M6zUo1aQnO7sCx9isrTsbI3dBOZ5OyBScg3BlIrusJNybP mUaD4fz/QN2ur0N4SLXbZ7zSguPVbTHH9imSiDAgUYO+mFs+OJEc13LS+j3YbQyp+BWIgF1+LqjQZ5 XY0g7iJGFNvKN49KoXwnlykdUL9BwwRazrOZp3VYMPVeDrjX6XEoyh9NqIU6vxPCSElqP4zh1Q9Rum N/6nJAdz9ug2WGIfhVvNVhtFw8kWrWifYwF9Qe6HZxdy6NuwWhgVDRt5/XgxSFS9JpEnbgzf+zN+uL cJ6QfNuljlkbQzs1z77/B7tu+clWifkhI1ZKakBatU0+j14yUeGqXWxk8CpozZCvN7YFBnri8B+YC+ eQKCssb9O4V1tCHcYtQySwrOSIVujqO+Fe28uD55dKPK8WygFEyy3mx9R6FuYWrSZXSu7XfiOzVRep NTOlfmk/Kb9IsyuJvML4ieFUr43G1NrhzV4KSjZMN8L8TLu/drZ5Z57aTtMbkqwTLV0d6/mXCxOQHY p9Y3RaDYvfuaGqECsjUFQ1fRqHhPiyBCzZq/NaWUTrqd/I8FqQLav3QpUZBQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Zero-length arrays are deprecated[1] and are being replaced with
flexible array members in support of the ongoing efforts to tighten the
FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.

Replace zero-length array with flexible-array member "lvs" in struct
opa_port_data_counters_msg and struct opa_port_error_counters64_msg.

Additionally, the "port" member of several structs is defined as a
single-element, but is only ever accessed at index 0. Replace it with a
singleton so that flexible array usage is sane.

This results in no differences in binary output.

[1] https://github.com/KSPP/linux/issues/78

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: cgel.zte@gmail.com
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/hfi1/mad.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index 4146a2113a95..e5e783c45810 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -2437,9 +2437,9 @@ struct opa_port_data_counters_msg {
 			__be64 port_vl_xmit_wait_data;
 			__be64 port_vl_rcv_bubble;
 			__be64 port_vl_mark_fecn;
-		} vls[0];
+		} vls[];
 		/* array size defined by #bits set in vl_select_mask*/
-	} port[1]; /* array size defined by  #ports in attribute modifier */
+	} port;
 };
 
 struct opa_port_error_counters64_msg {
@@ -2470,9 +2470,9 @@ struct opa_port_error_counters64_msg {
 		u8 reserved3[7];
 		struct _vls_ectrs {
 			__be64 port_vl_xmit_discards;
-		} vls[0];
+		} vls[];
 		/* array size defined by #bits set in vl_select_mask */
-	} port[1]; /* array size defined by #ports in attribute modifier */
+	} port;
 };
 
 struct opa_port_error_info_msg {
@@ -2543,7 +2543,7 @@ struct opa_port_error_info_msg {
 			u8 error_info;
 		} __packed fm_config_ei;
 		__u32 reserved9;
-	} port[1]; /* actual array size defined by #ports in attr modifier */
+	} port;
 };
 
 /* opa_port_error_info_msg error_info_select_mask bit definitions */
@@ -2966,7 +2966,7 @@ static int pma_get_opa_datacounters(struct opa_pma_mad *pmp,
 	}
 
 	/* Sanity check */
-	response_data_size = struct_size(req, port[0].vls, num_vls);
+	response_data_size = struct_size(req, port.vls, num_vls);
 
 	if (response_data_size > sizeof(pmp->data)) {
 		pmp->mad_hdr.status |= IB_SMP_INVALID_FIELD;
@@ -2986,7 +2986,7 @@ static int pma_get_opa_datacounters(struct opa_pma_mad *pmp,
 		return reply((struct ib_mad_hdr *)pmp);
 	}
 
-	rsp = &req->port[0];
+	rsp = &req->port;
 	memset(rsp, 0, sizeof(*rsp));
 
 	rsp->port_number = port;
@@ -3182,7 +3182,7 @@ static int pma_get_opa_porterrors(struct opa_pma_mad *pmp,
 		return reply((struct ib_mad_hdr *)pmp);
 	}
 
-	response_data_size = struct_size(req, port[0].vls, num_vls);
+	response_data_size = struct_size(req, port.vls, num_vls);
 
 	if (response_data_size > sizeof(pmp->data)) {
 		pmp->mad_hdr.status |= IB_SMP_INVALID_FIELD;
@@ -3201,7 +3201,7 @@ static int pma_get_opa_porterrors(struct opa_pma_mad *pmp,
 		return reply((struct ib_mad_hdr *)pmp);
 	}
 
-	rsp = &req->port[0];
+	rsp = &req->port;
 
 	ibp = to_iport(ibdev, port_num);
 	ppd = ppd_from_ibp(ibp);
@@ -3340,7 +3340,7 @@ static int pma_get_opa_errorinfo(struct opa_pma_mad *pmp,
 	u64 reg;
 
 	req = (struct opa_port_error_info_msg *)pmp->data;
-	rsp = &req->port[0];
+	rsp = &req->port;
 
 	num_ports = OPA_AM_NPORT(be32_to_cpu(pmp->mad_hdr.attr_mod));
 	num_pslm = hweight64(be64_to_cpu(req->port_select_mask[3]));
@@ -3590,7 +3590,7 @@ static int pma_set_opa_errorinfo(struct opa_pma_mad *pmp,
 	u32 error_info_select;
 
 	req = (struct opa_port_error_info_msg *)pmp->data;
-	rsp = &req->port[0];
+	rsp = &req->port;
 
 	num_ports = OPA_AM_NPORT(be32_to_cpu(pmp->mad_hdr.attr_mod));
 	num_pslm = hweight64(be64_to_cpu(req->port_select_mask[3]));
-- 
2.34.1

