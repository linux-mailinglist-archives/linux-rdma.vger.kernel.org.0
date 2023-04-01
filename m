Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC456D2EBA
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Apr 2023 08:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjDAGjG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Apr 2023 02:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjDAGip (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Apr 2023 02:38:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD0620C01
        for <linux-rdma@vger.kernel.org>; Fri, 31 Mar 2023 23:38:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id r7-20020a17090b050700b002404be7920aso23773856pjz.5
        for <linux-rdma@vger.kernel.org>; Fri, 31 Mar 2023 23:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1680331095;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tXE0+earW/yc9PR5Ch2dVMpBcTMVxdDOWwuUrgBYHMc=;
        b=N/maePfnCS8aULUtUFQcSP6WBroZnGY6BEBQLmcN+oNxBwagyetrky/v52UZ/FS9jf
         wijBQFSXF21C7/MoKpgAlVLGmhbpqToihnc5qF9DY1uiPnfBucS70U2srHdM+kVJS/HN
         TnQabD+mYDeiHv4wwhZiYZOi4GzEGIL7JnjlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680331095;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXE0+earW/yc9PR5Ch2dVMpBcTMVxdDOWwuUrgBYHMc=;
        b=AUdvW9TP5x4FsmP0UO4/RZFCJ+AdnvGV5gZMj6HjrlfH7p5sLodvrQMVQaDMwOsgnJ
         X9hLman+zH0gJeKtePhKZZlzzdi0Cv27r5GNPWXjmIKsFgfLnNC+gz933nUbChqJiWH6
         k0nYSw0UtC2R0h4cXUUt4Jv1666dzXddT2TQI0eoGTYUbnqZB+hNYaZBMrXm/V25KGfg
         /cVs9HEBTlzbqu9ZIloCmFPZA6K1kkFoe3g0YaUMqZWCIppj3Lr8Nfib8DYAQeicTyKu
         OYr1tBf1EMzdrLyEo9q657gXwIApK9ESXZ8fJLBkK+1VoZxZ6GMo+qt0FfZUjiWDkK+D
         gTIg==
X-Gm-Message-State: AAQBX9cGxvAqXT1Gui/+P45Dngr8ufganu1oy4/xQURYwYjhdXkjQlId
        zNv3iDVwv0XJ3phRX4WTZOzaYAsrUgIlscFoHtg=
X-Google-Smtp-Source: AKy350Yayz0cgDl9CYvTZOvk5Jzq1b/HWs4eZLnBXSj0XujYX9jeXGs+lIEh9RaD025qMgvAi2uJ6A==
X-Received: by 2002:a17:902:d503:b0:19d:1720:3873 with SMTP id b3-20020a170902d50300b0019d17203873mr35554888plg.57.1680331094610;
        Fri, 31 Mar 2023 23:38:14 -0700 (PDT)
Received: from localhost.localdomain ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902a60800b001a045f45d49sm2590060plq.281.2023.03.31.23.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 23:38:14 -0700 (PDT)
From:   Saravanan Vajravel <saravanan.vajravel@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH for-rc] RDMA/srpt: Add a check for valid 'mad_agent' pointer
Date:   Fri, 31 Mar 2023 23:38:00 -0700
Message-Id: <20230401063800.342432-1-saravanan.vajravel@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000085da705f840929d"
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000085da705f840929d
Content-Transfer-Encoding: 8bit

When unregistering MAD agent, srpt module has a non-null check
for 'mad_agent' pointer before invoking ib_unregister_mad_agent().
This check can pass if 'mad_agent' variable holds an error value.
The 'mad_agent' can have an error value for a short window when
srpt_add_one() and srpt_remove_one() is executed simultaneously.

In srpt module, added a valid pointer check for 'sport->mad_agent'
before unregistering MAD agent.

This issue can hit when RoCE driver unregisters ib_device

Stack Trace:
------------
BUG: kernel NULL pointer dereference, address: 000000000000004d
PGD 145003067 P4D 145003067 PUD 2324fe067 PMD 0
Oops: 0002 [#1] PREEMPT SMP NOPTI
CPU: 10 PID: 4459 Comm: kworker/u80:0 Kdump: loaded Tainted: P
Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.5.4 01/13/2020
Workqueue: bnxt_re bnxt_re_task [bnxt_re]
RIP: 0010:_raw_spin_lock_irqsave+0x19/0x40
Call Trace:
  ib_unregister_mad_agent+0x46/0x2f0 [ib_core]
  IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
  ? __schedule+0x20b/0x560
  srpt_unregister_mad_agent+0x93/0xd0 [ib_srpt]
  srpt_remove_one+0x20/0x150 [ib_srpt]
  remove_client_context+0x88/0xd0 [ib_core]
  bond0: (slave p2p1): link status definitely up, 100000 Mbps full duplex
  disable_device+0x8a/0x160 [ib_core]
  bond0: active interface up!
  ? kernfs_name_hash+0x12/0x80
 (NULL device *): Bonding Info Received: rdev: 000000006c0b8247
  __ib_unregister_device+0x42/0xb0 [ib_core]
 (NULL device *):         Master: mode: 4 num_slaves:2
  ib_unregister_device+0x22/0x30 [ib_core]
 (NULL device *):         Slave: id: 105069936 name:p2p1 link:0 state:0
  bnxt_re_stopqps_and_ib_uninit+0x83/0x90 [bnxt_re]
  bnxt_re_alloc_lag+0x12e/0x4e0 [bnxt_re]

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 3c3fae738c3e..07c24182b085 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -634,7 +634,7 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev, int port_cnt)
 	for (i = 1; i <= port_cnt; i++) {
 		sport = &sdev->port[i - 1];
 		WARN_ON(sport->port != i);
-		if (sport->mad_agent) {
+		if (!IS_ERR_OR_NULL(sport->mad_agent)) {
 			ib_modify_port(sdev->device, i, 0, &port_modify);
 			ib_unregister_mad_agent(sport->mad_agent);
 			sport->mad_agent = NULL;
-- 
2.31.1


--000000000000085da705f840929d
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
MDIwAgwz1tXFZ7RRpYwmQDswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN+l+mpk
hID2dF/iQxN2rP0ucRQx0OZIW1YzPz8YULDDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMDQwMTA2MzgxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBLNqKxxefL7doCupcUEcQ+1A1C
J8hzTOzbYpWmu2NgJG/VAvqF78dk55VTbyZx5ZFjKOfUlPitv4WQ+EilkQyc7VD1cI3xdqq+SLO5
9sM+ZF8JgNLcFRujm/2rAxcK8j1bgU5d5C+WYTINdfJehTBZb+ezMahjctQi2Ulm8Lxh2XAZ3z9R
RTD/+46RY46yzCzJ52YGDtRfc0CsD5bMERtG2UQx/fs6irDw7GJsXP1TmmT8OSLePXjXDITRMRrv
4xOrtjt2ZNrJcCAz0h9rVDHllWUCqJTVjXAyxeYHmrINtJ81GgbixV2HKgkzMsClYVksyLJGzr4Z
WTGHmPlL1vU7
--000000000000085da705f840929d--
