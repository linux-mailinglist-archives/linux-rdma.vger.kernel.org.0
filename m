Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A286D8E51
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Apr 2023 06:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjDFE0G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Apr 2023 00:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjDFE0E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Apr 2023 00:26:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9072D7AAC
        for <linux-rdma@vger.kernel.org>; Wed,  5 Apr 2023 21:26:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so41707540pjb.4
        for <linux-rdma@vger.kernel.org>; Wed, 05 Apr 2023 21:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1680755163; x=1683347163;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SR3Rk1MtedXhtg26U+8+OSNXS80zF5zmlSqQIur/4+o=;
        b=LWFjYwhw7bXCqrmIPok1nuXz8PSxQHXSjHMyYegDdMUvWio+lj86Kppoa0CEdM7CNw
         RdGZ1z3tFLTIexIpo6U86S2rzQMxzrb3qmiVeaCnbHhcaD0bw0jpznh98/pEpZySeh0a
         7ObVKwF6XFW3LF7ZI5QpAWojea1/DD27ObaW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680755163; x=1683347163;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SR3Rk1MtedXhtg26U+8+OSNXS80zF5zmlSqQIur/4+o=;
        b=u/26y1YDxQEn/wAngc1vPLyArQDSBRR2GSNaBYmgSEs1vdmmh5RuVvT90OQ0dDMJFe
         DFGva902sE0/CaOj0GqQjPMXLXQVEe2PE+uF3FoK+fJpicOLycCWYjh2/inu4azZdB9X
         AeU1EsRWLpMZAvvQHeiDs6FvGwFqBRr8ekQdtaXK6OjcK2whHx4eujpRcarAarioK/iB
         wCqz8dmgh6VHmzuefC6L2z2U3KXgclb+iOFHpg3nLl9p7lF7ncGCS9yehnx4mgu89AFj
         Gb+CVV59ILUpTzPQhzOMQc9LXNCmdkpIReb2Ezi8dGraBAM8rIOyOuEmjONBb0U793uf
         lBlg==
X-Gm-Message-State: AAQBX9ei7Pc/kios/j3t35KS7Gp2n1rEOjmupnTkije6IAPNXFd/Rm4M
        AloG+M0tolwUJEEUnIdpDKUkEQ==
X-Google-Smtp-Source: AKy350alKZPjCqOJQ3BWFA+kDx2IE4lC173ROymKm8I62VF3pMmpR1FXSQ5oXSftANUNEEPIbtVh+A==
X-Received: by 2002:a17:903:1246:b0:1a2:9ce6:6483 with SMTP id u6-20020a170903124600b001a29ce66483mr9917125plh.64.1680755162593;
        Wed, 05 Apr 2023 21:26:02 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0019f1027f88bsm309911plp.307.2023.04.05.21.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 21:26:01 -0700 (PDT)
From:   Saravanan Vajravel <saravanan.vajravel@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH v2 for-rc] RDMA/srpt: Add a check for valid 'mad_agent' pointer
Date:   Wed,  5 Apr 2023 21:25:49 -0700
Message-Id: <20230406042549.507328-1-saravanan.vajravel@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000077062105f8a34e83"
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000077062105f8a34e83
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
v1->v2:
   - Return pointer of mad_agent is stored in local pointer to verify
     if it is successfully registered

 drivers/infiniband/ulp/srpt/ib_srpt.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 3c3fae738c3e..b4cb88563bb2 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -549,6 +549,7 @@ static int srpt_format_guid(char *buf, unsigned int size, const __be64 *guid)
  */
 static int srpt_refresh_port(struct srpt_port *sport)
 {
+	struct ib_mad_agent *mad_agent;
 	struct ib_mad_reg_req reg_req;
 	struct ib_port_modify port_modify;
 	struct ib_port_attr port_attr;
@@ -593,23 +594,24 @@ static int srpt_refresh_port(struct srpt_port *sport)
 		set_bit(IB_MGMT_METHOD_GET, reg_req.method_mask);
 		set_bit(IB_MGMT_METHOD_SET, reg_req.method_mask);
 
-		sport->mad_agent = ib_register_mad_agent(sport->sdev->device,
-							 sport->port,
-							 IB_QPT_GSI,
-							 &reg_req, 0,
-							 srpt_mad_send_handler,
-							 srpt_mad_recv_handler,
-							 sport, 0);
-		if (IS_ERR(sport->mad_agent)) {
+		mad_agent = ib_register_mad_agent(sport->sdev->device,
+						  sport->port,
+						  IB_QPT_GSI,
+						  &reg_req, 0,
+						  srpt_mad_send_handler,
+						  srpt_mad_recv_handler,
+						  sport, 0);
+		if (IS_ERR(mad_agent)) {
 			pr_err("%s-%d: MAD agent registration failed (%ld). Note: this is expected if SR-IOV is enabled.\n",
 			       dev_name(&sport->sdev->device->dev), sport->port,
-			       PTR_ERR(sport->mad_agent));
+			       PTR_ERR(mad_agent));
 			sport->mad_agent = NULL;
 			memset(&port_modify, 0, sizeof(port_modify));
 			port_modify.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
 			ib_modify_port(sport->sdev->device, sport->port, 0,
 				       &port_modify);
-
+		} else {
+			sport->mad_agent = mad_agent;
 		}
 	}
 
-- 
2.31.1


--00000000000077062105f8a34e83
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
MDIwAgwz1tXFZ7RRpYwmQDswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA6SES2t
7nRF/de7OLg1ejzUDy9D0xfZjMwgB+1dw3Z8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMDQwNjA0MjYwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBKCeNiLO5FxpbTti7py0PM55c4
2dOm4Bz21BnpyV1/plwPW5/UrC90hsazx3c9FaUO5ZxE9E3kXbw+XjpWWr2+GVsV6bDBCZ+NXDFu
c730cH2ipKsW4MOJI5iRpaAZh79btuuG+sUWyOACKYLBRqbRCu1WVdWFQ7b4E302u9a/FbaAsM9F
p0PfCjBFK+fNq+BI87GQ224STcPXnWYBLb9qcxFEbuIPBJVYCCZHM4J4QcgNgSUMDc8wtCW3hk8l
HAji48H3WW7xpsIplcoUd+mpwYjqN1uue3h78zGOUWMGN4tdPNh4ZOyw0PqBrBNlZ3mTvrlJBRZu
u5jeNLVjZqrR
--00000000000077062105f8a34e83--
