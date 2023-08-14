Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2709A77B776
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Aug 2023 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjHNLVN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Aug 2023 07:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjHNLUy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Aug 2023 07:20:54 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD2E61
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 04:20:53 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77acb04309dso202696439f.2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692012053; x=1692616853;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v09oj9Eq5UHXnpSs2fL/BS8FuRdDS7Rd+18aAjJ8bys=;
        b=G5QdTnYYSiVXBkJJoPgiHBPFmKp+Ab8itsDnzJPPAKQW4/p9d/tR1wisOsAzpU9HEv
         5wFYQ60Wv7QnY2MfoTTRmn+yX6hdvuwrF8mxHm/4pqvjRKDCD5kIwrW3Ygj2u1fT2KAK
         ccBpqeKS4xtciuhur3ujRnnw/Q0PYeq7/nCPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692012053; x=1692616853;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v09oj9Eq5UHXnpSs2fL/BS8FuRdDS7Rd+18aAjJ8bys=;
        b=NlZLYfN+vjM4+owsgjQyPTZGx22+gsQquqAJDpwoTr6sbkAAApSFN6giO4o2LLImO8
         DsAfCkLd3ZDk6zGTs0n87eXd8WcnmAXNp7loL4zTRwK+HzpLZV2tjZ5Y/chGu9aNp6Bx
         b7KRLZkThQpykY62WLiPEt0oOnBeuqlvZWht23I5OSibQAEfGTIzX14HJzVxIFf4N5GO
         J9U8lcTA+WjTA/1KjSJDNKrUPwj5rbNwk8QykwWWK2Xwh/E6rESF8Bcvq+SO5GqLH/Ou
         QEiGVtG/aj6T3/J4dJEj3KAi1d69fDVYNzOK37eijYbOjDrFmbHDEwz/lCnuQG37y38x
         gI4Q==
X-Gm-Message-State: AOJu0Yx0U4UnTRamTRrHyZZBzaRl6Vc4uLzUmN7WYFz0nvZH0Tr9OdX6
        V5ovwrftyUm4z9/RY6RhexAPdiU5UwGWFyN98DstXA==
X-Google-Smtp-Source: AGHT+IG1nYl7CjScGEUchOaVSWCf3+o8Bvwp0y19fMOQSetMIGYbMIa/lhn8kUkMkiAh7P4EST+/Fi1ThxMoB59W0vQ=
X-Received: by 2002:a5e:a613:0:b0:77e:3598:e511 with SMTP id
 q19-20020a5ea613000000b0077e3598e511mr12795102ioi.2.1692012052905; Mon, 14
 Aug 2023 04:20:52 -0700 (PDT)
From:   Saravanan Vajravel <saravanan.vajravel@broadcom.com>
References: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com> <91d94243-3741-0098-cd3c-a6ebc8f21cf2@grimberg.me>
In-Reply-To: <91d94243-3741-0098-cd3c-a6ebc8f21cf2@grimberg.me>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGARhFlRJdvE4NsRpa1gch6MZ1PegIe4MozsIu7n+A=
Date:   Mon, 14 Aug 2023 16:50:51 +0530
Message-ID: <d24e75327e6a4bfea3a9cf195f233253@mail.gmail.com>
Subject: RE: isert patch leaving resources behind
To:     Sagi Grimberg <sagi@grimberg.me>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Cc:     Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006317710602e041d5"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000006317710602e041d5
Content-Type: text/plain; charset="UTF-8"

Hi Sagi,

In surprise removal case as well, isert_free_conn() should get invoked by
iSCSI target module. Right? I am trying to understand how the kernel object
leak is possible.  In your proposed patch, isert_conn is released in
isert_wait_conn() handler. Again, isert module tries to release the
connection in isert_free_conn() handler as well. Hence it will lead
use-after-free issue.

Following are the snippet of iSCSI functions where iscsit_wait_conn()  and
iscsit_free_conn() handlers are invoked in files iscsi_target_login.c &
iscsi_target.c. We need to review if there is a possibility that
iscsit_free_conn() is not invoked in any case. If yes, we may have to fix
that.

void  iscsi_target_login_sess_out
{
.
.
.
	if (conn->conn_transport->iscsit_wait_conn)
		conn->conn_transport->iscsit_wait_conn(conn);

	if (conn->conn_transport->iscsit_free_conn)
		conn->conn_transport->iscsit_free_conn(conn);
.
}

int iscsit_close_connection(
	struct iscsit_conn *conn)
{
.
.
.
	if (conn->conn_transport->iscsit_wait_conn)
		conn->conn_transport->iscsit_wait_conn(conn);
.
.
.
	if (conn->conn_transport->iscsit_free_conn)
		conn->conn_transport->iscsit_free_conn(conn);
.
.
}

@Leon,

I don't have the kernel logs in hand now. We can reproduce the issue and
share.

Thanks & Regards,
Saravanan Vajravel
+91-80-46116256

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me>
Sent: Sunday, August 13, 2023 7:49 PM
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>; OFED
mailing list <linux-rdma@vger.kernel.org>
Cc: Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>;
saravanan.vajravel@broadcom.com; Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: isert patch leaving resources behind



On 8/10/23 17:44, Dennis Dalessandro wrote:
> Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert
> connection") is causing problems on OPA when we try to unload the
> driver after doing iSCI testing. Reverting this commit causes the
> problem to go away. Any ideas? Was testing done on this patch with
> removing/hotplugging drivers?

You are correct, the patch is wrong because it doesn't fully release the
connection in ib device surprise removals.

Perhaps this should address this issue?
--
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c
b/drivers/infiniband/ulp/isert/ib_isert.c
index 92e1e7587af8..274ac9361fe7 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2570,6 +2570,9 @@ static void isert_wait_conn(struct iscsit_conn *conn)
         isert_put_unsol_pending_cmds(conn);
         isert_wait4cmds(conn);
         isert_wait4logout(isert_conn);
+
+       isert_put_conn(isert_conn);
+       conn->context = NULL;
  }

  static void isert_free_conn(struct iscsit_conn *conn)
--

--0000000000006317710602e041d5
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
MDIwAgwz1tXFZ7RRpYwmQDswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDaZIqOm
h1wJ1Bp214WftfEF2GXt/+4uF+buZesmZECpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMDgxNDExMjA1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDLIElL65f48FGnXVLgJaUmv0Rg
kxUGH1ZyudlKWzFufu0UKArwS12hpuFLOP1nJ2W5yHjhpEcL+5Z/IzsD9OEaG+5XyjtOM8EzOjje
sZEJge0RVDDkXTX0oVHujsYuMuhI9JDIoVNoRmvogVYWywrZDi8yUbpDcYnBnynd0SNzGT45zk38
cds8u9oHdOQfPlp1Usq8w39T0NDG1lNAkol97xr6AfdreXFEvuzO9H2k/4ZJD+mXLHfPb1Rr4pb+
BROX0HZ7slj93dMor3UH9PQP6jUSQLDH+s5q3ONae149aEa6hrqX2zZktnqe9yEAV7JG5gO0RqLd
5EALmNj37vYH
--0000000000006317710602e041d5--
