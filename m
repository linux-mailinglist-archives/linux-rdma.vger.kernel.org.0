Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337147480B9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGEJWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGEJW3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 05:22:29 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8553AA0;
        Wed,  5 Jul 2023 02:22:16 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id BIC00109;
        Wed, 05 Jul 2023 17:22:09 +0800
Received: from jtjnmail201606.home.langchao.com (10.100.2.6) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 17:22:08 +0800
Received: from jtjnmail201606.home.langchao.com ([fe80::8583:33f:807a:3430])
 by jtjnmail201606.home.langchao.com ([fe80::8583:33f:807a:3430%6]) with mapi
 id 15.01.2507.027; Wed, 5 Jul 2023 17:22:08 +0800
From:   =?gb2312?B?Um9jayBMaSjA7rrqzrAp?= <lihongweizz@inspur.com>
To:     "leon@kernel.org" <leon@kernel.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>,
        "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/iser: Protect tasks cleanup in case iser connection
 was stopped
Thread-Topic: [PATCH] IB/iser: Protect tasks cleanup in case iser connection
 was stopped
Thread-Index: AdmvGU9ORds3IdmXc0qwN4zLTm0C0g==
Date:   Wed, 5 Jul 2023 09:22:08 +0000
Message-ID: <45c68d6835964dcbae8fbd983696064b@inspur.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.180.207.169]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_016E_01D9AF65.38AB7A20"
MIME-Version: 1.0
tUid:   20237051722090abb66891f1b1e2eabce6c7294234d58
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

------=_NextPart_000_016E_01D9AF65.38AB7A20
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

> > On Tue, Jul 04, 2023 at 08:51:44AM +0800, lihongweizz wrote:
> > From: Rock Li <lihongweizz@inspur.com>
> >
> > We met a crash issue as below:
> > ...
> >  #7 [ff61b991f6f63d10] page_fault at ffffffffab80111e
> >     [exception RIP: iscsi_iser_cleanup_task+13]
> >     RIP: ffffffffc046c04d RSP: ff61b991f6f63dc0 RFLAGS: 00010246
> >     RAX: 0000000000000000 RBX: ff4bd0aalf7a5610 RCX: ff61b991f6f63dc8
> >     RDX: ff61b991f6f63d68 RSI: ff61b991f6f63d58 RDI: ff4bd0aalf6cdc00
> >     RBP: 0000000000000005 R8: 0000000000000073 R9:
> 0000000000000005
> >     R10: 0000000000000000 R11: 00000ccde3e0f5c0 R12:
> ff4bd08c0e0631f8
> >     R13: ff4bd0a95ffd3c78 R14: ff4bd0a95ffd3c78 R15: ff4bd0aalf6cdc00
> >     ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
> >  #8 [ff616991f6f63dc0] __iscsi_put_task at ffffffffc0bd3652 [libiscsi]
> >  #9 [ff61b991f6f63e00] iscsi_put_task at ffffffffc0bd36e9 [libiscsi]
> > ...
> >
> > After analysing the vmcore, we find that the iser connection was
> > already stopped before abort handler running. The iser_conn is already
> > unbindded and released. So we add iser connection validation check
> > inside cleanup task to fix this corner case.
> >
> > Signed-off-by: Rock Li <lihongweizz@inspur.com>
> > ---
> >  drivers/infiniband/ulp/iser/iscsi_iser.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c
> > b/drivers/infiniband/ulp/iser/iscsi_iser.c
> > index bb9aaff92ca3..35dfbf41fc40 100644
> > --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> > +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> > @@ -366,7 +366,12 @@ static void iscsi_iser_cleanup_task(struct
iscsi_task
> *task)
> >  	struct iscsi_iser_task *iser_task = task->dd_data;
> >  	struct iser_tx_desc *tx_desc = &iser_task->desc;
> >  	struct iser_conn *iser_conn = task->conn->dd_data;
> > -	struct iser_device *device = iser_conn->ib_conn.device;
> > +	struct iser_device *device;
> > +
> > +	/* stop connection might happens before iser cleanup work */
> > +	if (!iser_conn)
> > +		return;
> 
> And what prevents from iser_conn being not valid here?
> For example, in the flow:
> 1. Start iscsi_iser_cleanup_task
> 2. Get valid task->conn->dd_data
> 3. Pass this if (..) check
> 4. Context switch and release connection 5. iser_conn now points to
released
> memory.
> 
> Thanks

Hi Leon,
Thanks for your reply:) In case iscsi_stop_conn was executed cocurrently or
after iscsi_iser_cleanup_task, above issue would happen.
I've confirmed the values in iscsi_cls_conn and iscsi_conn instances from
vmcore:

iscsi_stop_conn
  ...
  WRITE_ONCE(conn->state, ISCSI_CONN_FAILED);      --- confirmed
  ...
  conn->transport->stop_conn => iscsi_iser_conn_stop
    iscsi_conn_stop
      ...
      conn->c_stage = ISCSI_CONN_STOPPED;          --- confirmed
    conn->dd_data = NULL;                          --- confirmed

The crash scene tells us that iscsi_stop_conn was executed before
iscsi_iser_cleanup_task start, the iser_conn instance was already released. 

> 
> > +	device = iser_conn->ib_conn.device;
> >
> >  	/* DEVICE_REMOVAL event might have already released the device */
> >  	if (!device)
> > --
> > 2.27.0
> >

------=_NextPart_000_016E_01D9AF65.38AB7A20
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
BggqhkiG9w0DAgICAIAwDgYIKoZIhvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMB0GA1Ud
DgQWBBRaBc9d7NDesVRKJOjt1innorCQlzAfBgNVHSMEGDAWgBReWQOmtExYYJFO9h61pTmmMsE1
ajCCAQ8GA1UdHwSCAQYwggECMIH/oIH8oIH5hoG6bGRhcDovLy9DTj1JTlNQVVItQ0EsQ049SlRD
QTIwMTIsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNv
bmZpZ3VyYXRpb24sREM9aG9tZSxEQz1sYW5nY2hhbyxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0
aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hjpodHRwOi8vSlRD
QTIwMTIuaG9tZS5sYW5nY2hhby5jb20vQ2VydEVucm9sbC9JTlNQVVItQ0EuY3JsMIIBKQYIKwYB
BQUHAQEEggEbMIIBFzCBsQYIKwYBBQUHMAKGgaRsZGFwOi8vL0NOPUlOU1BVUi1DQSxDTj1BSUEs
Q049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixE
Qz1ob21lLERDPWxhbmdjaGFvLERDPWNvbT9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9
Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBhBggrBgEFBQcwAoZVaHR0cDovL0pUQ0EyMDEyLmhvbWUu
bGFuZ2NoYW8uY29tL0NlcnRFbnJvbGwvSlRDQTIwMTIuaG9tZS5sYW5nY2hhby5jb21fSU5TUFVS
LUNBLmNydDBJBgNVHREEQjBAoCYGCisGAQQBgjcUAgOgGAwWbGlob25nd2VpenpAaW5zcHVyLmNv
bYEWbGlob25nd2VpenpAaW5zcHVyLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAbgg5pyExgLZRaa7t
7XYfCwnVeO7Fzb2IyHLpR6UJw3tMeftOi+j+eM1PjvDxixho7R8lDhCGkoIwXdtJfXMMEfGTnXmh
+oY9PrWfhlgCn6ZeU633jtV5kDi8JFa/g7JP0SgZvOCsxbHJXM78HKy8gUUsLrXJ8yKHzt/uEgUK
ekHEjh1eWmxvCXuLyCd15SVIgDuVvXipcygfdbc52JrhLab4IgDUq+4SKC7X9s6iUdbyxq8T0aA6
2C0AmIIbJyG6cLAMmSSOMzM31hiflRiGmJOqpcjFsd1+1GTy1KM+jvmTJFiadG1bx5AhuWoXKyst
fQgatmAtt6XCB7rmbjOapDGCA5MwggOPAgEBMHAwWTETMBEGCgmSJomT8ixkARkWA2NvbTEYMBYG
CgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAGA1UEAxMJSU5T
UFVSLUNBAhN+AADCsSyiGj7nnfwAAAAAAMKxMAkGBSsOAwIaBQCgggH4MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcwNTA5MjIwNlowIwYJKoZIhvcNAQkEMRYE
FOXW4Sz/NiwgUtK1iIdOACFoalTvMH8GCSsGAQQBgjcQBDFyMHAwWTETMBEGCgmSJomT8ixkARkW
A2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZImiZPyLGQBGRYEaG9tZTESMBAG
A1UEAxMJSU5TUFVSLUNBAhN+AADCsSyiGj7nnfwAAAAAAMKxMIGBBgsqhkiG9w0BCRACCzFyoHAw
WTETMBEGCgmSJomT8ixkARkWA2NvbTEYMBYGCgmSJomT8ixkARkWCGxhbmdjaGFvMRQwEgYKCZIm
iZPyLGQBGRYEaG9tZTESMBAGA1UEAxMJSU5TUFVSLUNBAhN+AADCsSyiGj7nnfwAAAAAAMKxMIGT
BgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzAL
BglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIaMAsGCWCG
SAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGmPA1PP
GyegA96azdOx2Wwku9Y1oSk13yfu4y12D9gp03iB8HtHI+3zA2JSu9xs2/4UbLimsy+kPT08MKOq
5o97vwyn4/lyYfQxKAjrh4S6BBeoTZnlAqK6kCsODYQNWOa/WFNgHuLkoT2+23rm7ONLilTXSpDl
b7W7SWU2nLRDa/IfxDj156QerpRKR87GZXUPqSGbHj2I6eEcP/icXV0hU6flWp6IHhgt8Qe3cEm7
1q0iF/rfzZ4K9XbIHX5ha8/zqBXWnwYgO7r7jhyVZuuF9e+TfQOfAUXgFsMBM2xZzkiV8TEP51dx
Ak4ZEDyz7dQuNoudbLxRZFg5JN5N0uUAAAAAAAA=

------=_NextPart_000_016E_01D9AF65.38AB7A20--
