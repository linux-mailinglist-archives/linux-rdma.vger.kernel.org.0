Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A80B723F52
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjFFKZx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjFFKZv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 06:25:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18DE8
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 03:25:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53f04fdd77dso2296550a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jun 2023 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686047149; x=1688639149;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYCey2jwN9PkhHmk6JpaGJT0AY9JQSiYUg+FOD0m3eM=;
        b=Nu0/RIaQBm2ty7oLWWrrTDR8QdC9q7LCFVtbzQPZSwQHS4gsgcrKKoJ51QutnFVYoP
         FlIyulMN3Q7e8p7j2GQsgeW7iKiVnOVfrg82nlkbo+EP9d/kChq7PINyb4HberE3fFgh
         kDj2+BgKr4nPRryPO9qf7AyKivzJDRJh3ULNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047149; x=1688639149;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYCey2jwN9PkhHmk6JpaGJT0AY9JQSiYUg+FOD0m3eM=;
        b=A+0Gz/fxVds0Hj9xH8Wkb6d05msQA1cp1kLBaqow8Rrsi8tmljx74k217ggYbNrsX4
         3QFUnKPtBkW0ox5p3Wfejwfx1dRUtkA1fcxJkqiXeKmOrl1T0taE7rEEozCxPABYAr8R
         4H0YCPtUFY8QBK0BpM7NfD2pxk4iPHOrCruPpJXITuG/0yALPH79f5V/YtppPo6arFGi
         J1MXzQ5F5s3PEM9/h/6cA8zigGaVPYnxV0L3ZGn+6jCjKYnYIY8NJ5FVuPFpwGHd0yA7
         Dl3DgOnNmUnS6ptukooBMRU8KfK7cHtSKCU1JQbikyfEy6N27AoyzOYg/lv0RAsxPlTC
         cXzQ==
X-Gm-Message-State: AC+VfDxqDPzNMqnSQ7ciZ1KeAssSONNDjPLNxxfvQDK6IL+P1cfW+FG4
        2GPI8B2u+IJ6sM6iPBHVbFu+xA==
X-Google-Smtp-Source: ACHHUZ4G+7G1Op/fSOu87kvgRXMJGGHgO5ItRN/GaYsMyyH5iFSJ+HJsKffNY61SIGUdM4YNT70Fnw==
X-Received: by 2002:a17:90a:ee93:b0:24d:f8e6:9d4c with SMTP id i19-20020a17090aee9300b0024df8e69d4cmr496569pjz.49.1686047149170;
        Tue, 06 Jun 2023 03:25:49 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090a2a0c00b0024c1ac09394sm7881770pjd.19.2023.06.06.03.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:25:48 -0700 (PDT)
From:   Saravanan Vajravel <saravanan.vajravel@broadcom.com>
To:     selvin.xavier@broadcom.com, jgg@ziepe.ca, leon@kernel.org,
        sagi@grimberg.me
Cc:     linux-rdma@vger.kernel.org,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: [PATCH v3 for-rc 1/3] IB/isert: Fix dead lock in ib_isert
Date:   Tue,  6 Jun 2023 03:25:29 -0700
Message-Id: <20230606102531.162967-2-saravanan.vajravel@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230606102531.162967-1-saravanan.vajravel@broadcom.com>
References: <20230606102531.162967-1-saravanan.vajravel@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006e92bf05fd7371ce"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000006e92bf05fd7371ce
Content-Transfer-Encoding: 8bit

- When a iSER session is released, ib_isert module is taking a mutex
  lock and releasing all pending connections. As part of this, ib_isert
  is destroying rdma cm_id. To destroy cm_id, rdma_cm module is sending
  CM events to CMA handler of ib_isert. This handler is taking same
  mutex lock. Hence it leads to deadlock between ib_isert & rdma_cm
  modules.

- For fix, created local list of pending connections and release the
  connection outside of mutex lock.

Calltrace:
---------
[ 1229.791410] INFO: task kworker/10:1:642 blocked for more than 120 seconds.
[ 1229.791416]       Tainted: G           OE    --------- -  - 4.18.0-372.9.1.el8.x86_64 #1
[ 1229.791418] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1229.791419] task:kworker/10:1    state:D stack:    0 pid:  642 ppid:     2 flags:0x80004000
[ 1229.791424] Workqueue: ib_cm cm_work_handler [ib_cm]
[ 1229.791436] Call Trace:
[ 1229.791438]  __schedule+0x2d1/0x830
[ 1229.791445]  ? select_idle_sibling+0x23/0x6f0
[ 1229.791449]  schedule+0x35/0xa0
[ 1229.791451]  schedule_preempt_disabled+0xa/0x10
[ 1229.791453]  __mutex_lock.isra.7+0x310/0x420
[ 1229.791456]  ? select_task_rq_fair+0x351/0x990
[ 1229.791459]  isert_cma_handler+0x224/0x330 [ib_isert]
[ 1229.791463]  ? ttwu_queue_wakelist+0x159/0x170
[ 1229.791466]  cma_cm_event_handler+0x25/0xd0 [rdma_cm]
[ 1229.791474]  cma_ib_handler+0xa7/0x2e0 [rdma_cm]
[ 1229.791478]  cm_process_work+0x22/0xf0 [ib_cm]
[ 1229.791483]  cm_work_handler+0xf4/0xf30 [ib_cm]
[ 1229.791487]  ? move_linked_works+0x6e/0xa0
[ 1229.791490]  process_one_work+0x1a7/0x360
[ 1229.791491]  ? create_worker+0x1a0/0x1a0
[ 1229.791493]  worker_thread+0x30/0x390
[ 1229.791494]  ? create_worker+0x1a0/0x1a0
[ 1229.791495]  kthread+0x10a/0x120
[ 1229.791497]  ? set_kthread_struct+0x40/0x40
[ 1229.791499]  ret_from_fork+0x1f/0x40

[ 1229.791739] INFO: task targetcli:28666 blocked for more than 120 seconds.
[ 1229.791740]       Tainted: G           OE    --------- -  - 4.18.0-372.9.1.el8.x86_64 #1
[ 1229.791741] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1229.791742] task:targetcli       state:D stack:    0 pid:28666 ppid:  5510 flags:0x00004080
[ 1229.791743] Call Trace:
[ 1229.791744]  __schedule+0x2d1/0x830
[ 1229.791746]  schedule+0x35/0xa0
[ 1229.791748]  schedule_preempt_disabled+0xa/0x10
[ 1229.791749]  __mutex_lock.isra.7+0x310/0x420
[ 1229.791751]  rdma_destroy_id+0x15/0x20 [rdma_cm]
[ 1229.791755]  isert_connect_release+0x115/0x130 [ib_isert]
[ 1229.791757]  isert_free_np+0x87/0x140 [ib_isert]
[ 1229.791761]  iscsit_del_np+0x74/0x120 [iscsi_target_mod]
[ 1229.791776]  lio_target_np_driver_store+0xe9/0x140 [iscsi_target_mod]
[ 1229.791784]  configfs_write_file+0xb2/0x110
[ 1229.791788]  vfs_write+0xa5/0x1a0
[ 1229.791792]  ksys_write+0x4f/0xb0
[ 1229.791794]  do_syscall_64+0x5b/0x1a0
[ 1229.791798]  entry_SYSCALL_64_after_hwframe+0x65/0xca

Fixes: bd3792205aae ("iser-target: Fix pending connections handling in target stack shutdown sequnce")
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index f290cd49698e..b4809d237250 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2431,6 +2431,7 @@ isert_free_np(struct iscsi_np *np)
 {
 	struct isert_np *isert_np = np->np_context;
 	struct isert_conn *isert_conn, *n;
+	LIST_HEAD(drop_conn_list);
 
 	if (isert_np->cm_id)
 		rdma_destroy_id(isert_np->cm_id);
@@ -2450,7 +2451,7 @@ isert_free_np(struct iscsi_np *np)
 					 node) {
 			isert_info("cleaning isert_conn %p state (%d)\n",
 				   isert_conn, isert_conn->state);
-			isert_connect_release(isert_conn);
+			list_move_tail(&isert_conn->node, &drop_conn_list);
 		}
 	}
 
@@ -2461,11 +2462,16 @@ isert_free_np(struct iscsi_np *np)
 					 node) {
 			isert_info("cleaning isert_conn %p state (%d)\n",
 				   isert_conn, isert_conn->state);
-			isert_connect_release(isert_conn);
+			list_move_tail(&isert_conn->node, &drop_conn_list);
 		}
 	}
 	mutex_unlock(&isert_np->mutex);
 
+	list_for_each_entry_safe(isert_conn, n, &drop_conn_list, node) {
+		list_del_init(&isert_conn->node);
+		isert_connect_release(isert_conn);
+	}
+
 	np->np_context = NULL;
 	kfree(isert_np);
 }
-- 
2.31.1


--0000000000006e92bf05fd7371ce
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBV4wggRGoAMCAQICDDPW1cVntFGljCZAOzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTE0NTZaFw0yNTA5MTAwOTE0NTZaMIGa
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGzAZBgNVBAMTElNhcmF2YW5hbiBWYWpyYXZlbDEuMCwGCSqG
SIb3DQEJARYfc2FyYXZhbmFuLnZhanJhdmVsQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOWUDY8+1Pq6qzzsf5oTzGO7etyb0HT08NkGz7Ymb6gL2BcSxf00xj2f
fgOR3x1R5vZCQL+NXGnk27IMYe6P1jT2e49wq24CtJxpjbdCgiY+wM0iowrqj+xHJyGEyFK7BEOB
1cEV+/7fNvlT+wzsiB6LI7YO2jnJoqRyxiuCXWXQteLT5u5dJd79gUxenL2sOdzc9QDElI3VQMfh
lU2WOYSpsHwmuzI2n56f4qqAd0KTzesYpT4jUkHrpARqokmK62nwak/mVjpP1xxKkerBRTDplTRj
PPaP6wQe1OY7fOWrqgKUrMkQ8uzH68KFHiA/+zIzyFmYwY+S3kdoi+SvK08CAwEAAaOCAeAwggHc
MA4GA1UdDwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
dDBBBggrBgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFs
c2lnbjJjYTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+
oDygOoY4aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MC5jcmwwKgYDVR0RBCMwIYEfc2FyYXZhbmFuLnZhanJhdmVsQGJyb2FkY29tLmNvbTATBgNVHSUE
DDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU
0Bq3qvsz+PB5FAu5iL1KRdtSBTgwDQYJKoZIhvcNAQELBQADggEBAHXOk8r6/lLV2Fb8uE3tUP2E
MFD67H9X0roxhLywKzY+SM6abiUqsRxlcBwNgp0r/SwFG1o+frLlj7gynwfkzfsRzLRf//DYTUOF
qs8Os28DFCa/KvX0e56+c7xOOP9cwgHO3Tl2ri3MAGpxEB5r4PcgmWd4f9zmlmBGE9oNyoyntToB
pb/Gi74xj8wc5zCrVpXS1UNVJ8B6Jib+vas1cAtL6RFi0RDtFbUXe9U4wB07Ker1yMtBA6QzfZW2
d0VRyjqv9NL22cjJ4ffotr8ZKbiSVEHbnDRxAgeuMxkkpjQQk/y1S1fk0wDOYNfV0zIkWtVMNBzY
Ttmt2pp+/hwLYVAxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAy
MDIwAgwz1tXFZ7RRpYwmQDswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINzJ6X5+
1VESe4r40g9UhEjXidq76qRvdbAHZWgi24LjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMDYwNjEwMjU0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBjo7TqB7SImidY0kloL8l8egOh
CCO0XdTkeQ0uftsmWiOk8RF/imwB8HZqlCzO2aceWWPwZ8x3i5SjgVL3GGBHPEcFGQao8Jiy0ZJj
oE5THhFLP2ZLGYD7QWdHVsGlqaeqouo19/41xdJ733ZYfb4JpH7Y233/hCVKQ/vRor+y8ZWo7aYz
2SRhvS3apVH66W8WDNjwNQAUJyHj7xVKaWDJJHQT7lVnys8oiv97P5IAt5yAI1Ohhq4OiTR40z1i
yXYbf5OMAh91+Oglss1A60vJVJABT9wahLXMQiIMZH10RUlfyG6hD8FgR0eOwwTojkCchZvItSnM
3Ilh4Fto3YWF
--0000000000006e92bf05fd7371ce--
