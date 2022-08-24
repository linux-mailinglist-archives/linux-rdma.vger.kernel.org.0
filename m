Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E2059FA2C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 14:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiHXMn4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Aug 2022 08:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiHXMn4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Aug 2022 08:43:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17D0696C6
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 05:43:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f21so16924662pjt.2
        for <linux-rdma@vger.kernel.org>; Wed, 24 Aug 2022 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc;
        bh=RY5fJt5pBkeV13hstwSAh2HxJAvcMB4XLOhwdqrBZto=;
        b=JHiJrXymHXnTaVtLDq5QKQ9pIV0420KMrMpjwvpJ7s4vz/N7K3qCrXU4FxKG6AOGGh
         W0AXTmP4o+giflP3sEvQS6EJ8GGReXT6wdLSuTVd4DQtnht0GsoipTZVo6fCL8RMyl2p
         n7/HIy4mbIc7GhTtZZVIO0owcE2H5FV25eRNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=RY5fJt5pBkeV13hstwSAh2HxJAvcMB4XLOhwdqrBZto=;
        b=p3lnc2fQs7BHz6k0yZnZhbHOAw8ieiU4KnTk5wqitthCp3bYS1Jm9kdr5zc0aCb5Uv
         ozjpNcrP9g9T17Ub0rf5ga+2AzQEtgPvKq5Wkz1CovOy0SFWQtdm1Mg1wXrCeRs1fAdW
         uvdIHnRYh5v7+Df55eQSgJgH62tm4+olU/rikeSxZ88O0Kix41++vO9t8e9chqj6zb7D
         xLnfXK/vpegm1DEJjBN6N76x+lOrGltp5UTZSiXE3AlGfR7ZbHFDKy/dFJBAQtrEiCfw
         PUfLz/o1qpmRAzYuXxpZP74fA3FKEQx+AwaCLEqwQIkDivgj1bJJYlB05vH2AfnLoU1/
         8jSA==
X-Gm-Message-State: ACgBeo2nA1oEXPSuyILjBo8Nmk5VPC3C8D+N5ht1z3xZ68Cd9JVn15BF
        xTOzLI6WEutUUrk1gU210JjKq9FKrTfM6+VE6Wgvs3QpzV2iKYctcsGdo6d1swygFjctVCJOzNb
        X+vgHfZZ6NGtcacXO7gCx7IA6MXpZJ9dPt5iLOZwWUiWX05mdLPPIXQeHQkJTmseezKhwZk68I0
        iW8XcfImxo
X-Google-Smtp-Source: AA6agR5BNQDnou7KQLNn0IxyIyqdRVFsnWVuQeikKDVeJFSiZqQnUT8Vbk0uJJMpBBGSNdXg0DzwmA==
X-Received: by 2002:a17:903:1ce:b0:16f:145c:a842 with SMTP id e14-20020a17090301ce00b0016f145ca842mr28312933plh.83.1661345034031;
        Wed, 24 Aug 2022 05:43:54 -0700 (PDT)
Received: from amd_smc.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j2-20020a63fc02000000b0041a615381d5sm11010769pgi.4.2022.08.24.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:43:52 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     selvin.xavier@broadcom.com, andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Max Gurtovoy" <mgurtovoy@nvidia.com>,
        "Sagi Grimberg" <sagi@grimberg.me>
Subject: [PATCH RFC] IB/iser: add task reference counter for tx commands
Date:   Wed, 24 Aug 2022 18:12:36 +0530
Message-Id: <20220824124236.812395-1-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a2c15505e6fc08fa"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000a2c15505e6fc08fa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In [0], Max Gurtovoy already explained a future plan to add reference
count.

Below example has Initiator Task Tag = 0x1e. We are tracking the same ITT.

        [177617.255969]  session508: iscsi_prep_scsi_cmd_pdu iscsi prep [write cid 0 sc 000000009d6ff976 cdb 0x2a itt 0x1e len 8192 cmdsn 90 win 64]
        [177617.255982] iser: iscsi_iser_task_xmit: cmd [itt 1e total 8192 imm 8192 unsol_data 0
(1) >>  [177617.255985] iser: iscsi_iser_task_xmit: ctask xmit [cid 0 itt 0x1e]
        [177617.255992] iser: iser_reg_dma: Single DMA entry: lkey=0xffffffff, rkey=0x0, addr=0x9c5de000, length=0x2000
        [177617.255995] iser: iser_prepare_write_cmd: Cmd itt:30, WRITE, adding imm.data sz: 8192
        [177617.256002] iser: iser_send_command: from iser_send_command iser_task ffff9e39dad96898 tx_count 1
(2) >>  [177617.256016] iser: iser_cmd_comp: from iser_cmd_comp iser_task ffff9e39dad96898 tx_count 0
(3) >>  [177617.256045] iser: iser_task_rsp: op 0x21 itt 0x1e dlen 0
        [177617.256049]  session508: __iscsi_complete_pdu [op 0x21 cid 0 itt 0x1e len 0]
        [177617.256052]  session508: iscsi_scsi_cmd_rsp cmd rsp done [sc 000000009d6ff976 res 0 itt 0x1e]
        [177617.256055]  session508: iscsi_complete_task complete task itt 0x1e state 3 sc 000000009d6ff976
(4) >>  [177617.256057]  session508: iscsi_free_task freeing task itt 0x1e state 1 sc 000000009d6ff976
(5) >>  [177617.256067] bnxt_en 0000:21:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x001e address=0x41137800 flags=0x0000]
        [177617.256068] bnxt_en 0000:21:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x001e address=0xc1595098 flags=0x0000]

(1) Is when iser stack has posted TX DESC type = ISCSI_TX_SCSI_COMMAND having two SGL.
    sgl[0] is contain iscsi_header and sgl[1] is scsi data (of length 8K)
    of scsi command cdb = WRITE_10
(2) In a good case, TX completion is received,
    but in some cases TX completion is not yet received to the iser stack.
(3) Is when iser stack gets completion of RX DESC of ITT = 0x1e.
    This is actual scsi completion of TX_DESC from target.
(4) Is when the iser stack destroys all TX DESC resources associated with ITT = 0x1e.
(5) Is when HCA is still accessing WQE entry of ITT = 0x1e (possible in retransmission path).
    After (4), sgl[0] and sgl[1] dma addresses are unmapped and not allowed to be used by HCA.

Get the iscsi_task reference count if TX DESC is successfully posted.
Put the iscsi_task reference count once TX_DESC is completed.
This method will make sure iscsi_free_task will be called only after TX
and RX DESC received for the task->itt.
 
This patch depends upon [0] as it required signaled completion.

[0] https://patchwork.kernel.org/project/linux-rdma/patch/20211215135721.3662-5-mgurtovoy@nvidia.com/

Cc: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: "Max Gurtovoy" <mgurtovoy@nvidia.com>
Cc: "Sagi Grimberg" <sagi@grimberg.me>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c     | 5 ++++-
 drivers/infiniband/ulp/iser/iser_initiator.c | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index 620ae5b2d80d..f1704fef9dc8 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -339,9 +339,12 @@ static int iscsi_iser_task_xmit(struct iscsi_task *task)
 
 	/* Send the cmd PDU */
 	if (!iser_task->command_sent) {
+		iscsi_get_task(task);
 		error = iser_send_command(conn, task);
-		if (error)
+		if (error) {
+			iscsi_put_task(task);
 			goto iscsi_iser_task_xmit_exit;
+		}
 		iser_task->command_sent = 1;
 	}
 
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 7b83f48f60c5..1f0b1601b3b3 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -669,6 +669,12 @@ void iser_task_rsp(struct ib_cq *cq, struct ib_wc *wc)
 
 void iser_cmd_comp(struct ib_cq *cq, struct ib_wc *wc)
 {
+	struct iser_tx_desc *desc = iser_tx(wc->wr_cqe);
+	struct iscsi_task *task;
+	task = (void *)desc - sizeof(struct iscsi_task);
+
+	iscsi_put_task(task);
+
 	if (unlikely(wc->status != IB_WC_SUCCESS))
 		iser_err_comp(wc, "command");
 }
-- 
2.31.1


--000000000000a2c15505e6fc08fa
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA7JIUIg5R85B9t+3Ta1BonMLOgi
Ij3+LeXQJXiotUUCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDgyNDEyNDM1NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCzOnw5NIvmKM9YXcawOWv1URxwX6zRW1y1arjcuA+v7oNn
xIfc2LnvFUNo/Gy9xYyEtUl8qSU0qw9eFUsnA/upOSFH4h65dimaHqsi5NOcQeNLXGSjalwew4pn
D3L3ttV38/gqlgBG35TXdV/CRy1L5Mmz+V+7+O1G/yh7qZz0lvii8zcpEi/feVzsbL8gaoVn3aW5
HIOCzOMDg/Ci06yXkGKCg/UUfKYC1+D4Y+RnJ+qT7LbZCFlg3TK6RLUlNXp9UF+SDKd4R9j0Mx3P
t2iCk/8STTwSY1WeeKW6kWoed467C+82PrfHoGHibX04bP42Uy8/AoUVrZijYUcSMdoC
--000000000000a2c15505e6fc08fa--
