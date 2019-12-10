Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82DD118EF4
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2019 18:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfLJRZM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Dec 2019 12:25:12 -0500
Received: from postout2.mail.lrz.de ([129.187.255.138]:40045 "EHLO
        postout2.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfLJRZM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Dec 2019 12:25:12 -0500
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 47XRlT5TztzyZ7
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2019 18:25:09 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=lrz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lrz.de; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:x-mailer:content-language:accept-language
        :message-id:date:date:subject:subject:from:from:received
        :received:received:received; s=postout; t=1575998709; bh=XGXBxwb
        URh6OraxrfE7kC/ypdIPJhleDVXCzsYamDbw=; b=ytT4uXTg7gJqDZ+7tRubGbt
        EYdLBAw01L8dW4ibOhC2qlO0rWgcwnIf4hTRadV40EV5ZrNVBYOUM6jbUxilUGdC
        KtChCbu8rBa/YAFMp6AxLTjWqFKWwivmM8IRDGkQHDCSb5K4dpRcnfljK4qCWR2U
        SzUba460c+JBI8l1dZIIIX1EaJ/G0SHCA8L5hm4noCHJyS9KoPFp01sLRFoev5/2
        h1zFR6ZWRP9tDHTKHvh0lFhILpkCq3vE+c+di3lh8dGeh+RwEkwc3xsi4H7j0yKC
        vslaI/H/S1dPiB73d02M6Wi//hv+YzX2aYMYjexhDBUtNU/3qHhBmySQqw2xgmg=
        =
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -0.574
X-Spam-Level: 
X-Spam-Status: No, score=-0.574 tagged_above=-999 required=5
        tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, DMARC_ADKIM_RELAXED=0.001,
        DMARC_ASPF_RELAXED=0.001, DMARC_POLICY_NONE=0.001,
        LRZ_CTE_BASE64=0.001, LRZ_CT_PLAIN_UTF8=0.001, LRZ_DATE_TZ_0000=0.001,
        LRZ_DKIM_DESTROY_MTA=0.001, LRZ_DMARC_FAIL=0.001,
        LRZ_DMARC_LRZ_FAIL=0.001, LRZ_DMARC_OVERWRITE=0.001,
        LRZ_DMARC_POLICY=0.001, LRZ_ENVFROM_FROM_ALIGNED_STRICT=0.001,
        LRZ_ENVFROM_FROM_MATCH=0.001, LRZ_ENVFROM_LRZ_S=0.001,
        LRZ_FROM_AP_PHRASE=0.001, LRZ_FROM_HAS_A=0.001,
        LRZ_FROM_HAS_MDOM=0.001, LRZ_FROM_HAS_MX=0.001,
        LRZ_FROM_HOSTED_DOMAIN=0.001, LRZ_FROM_LRZ_S=0.001,
        LRZ_FROM_NAME_IN_ADDR=0.001, LRZ_FROM_PHRASE=0.001,
        LRZ_FROM_PRE_SUR_ADDR=0.001, LRZ_FWD_MS_EX=0.001, LRZ_HAS_CLANG=0.001,
        LRZ_HAS_SPF=0.001, LRZ_HAS_THREAD_INDEX=0.001,
        LRZ_HAS_X_ORIG_IP=0.001, LRZ_MSGID_APPLE_MAIL=0.001,
        LRZ_RCVD_BADWLRZ_EXCH=0.001, LRZ_RCVD_MS_EX=0.001, LRZ_RDNS_NONE=1.5,
        LRZ_XM_APPLE=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001]
        autolearn=no autolearn_force=no
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id BS7pxpK9ICJH for <linux-rdma@vger.kernel.org>;
        Tue, 10 Dec 2019 18:25:09 +0100 (CET)
Received: from BADWLRZ-SWMBX05.ads.mwn.de (BADWLRZ-SWMBX05.ads.mwn.de [IPv6:2001:4ca0:0:108::161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "BADWLRZ-SWMBX05", Issuer "BADWLRZ-SWMBX05" (not verified))
        by postout2.mail.lrz.de (Postfix) with ESMTPS id 47XRlT3HyhzyYr
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2019 18:25:09 +0100 (CET)
Received: from BADWLRZ-SWMBX05.ads.mwn.de (2001:4ca0:0:108::161) by
 BADWLRZ-SWMBX05.ads.mwn.de (2001:4ca0:0:108::161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 10 Dec 2019 18:25:08 +0100
Received: from BADWLRZ-SWMBX05.ads.mwn.de ([fe80::4095:4fb3:50be:d2bd]) by
 BADWLRZ-SWMBX05.ads.mwn.de ([fe80::4095:4fb3:50be:d2bd%12]) with mapi id
 15.01.1713.009; Tue, 10 Dec 2019 18:25:08 +0100
From:   "Mijakovic, Robert" <Robert.Mijakovic@lrz.de>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Problem installing rdma-core 25+ due to incorrect file name in
 rdma_man_pages
Thread-Topic: Problem installing rdma-core 25+ due to incorrect file name in
 rdma_man_pages
Thread-Index: AQHVr37F3p1rauN9vEC6zsBA1OSa1w==
Date:   Tue, 10 Dec 2019 17:25:08 +0000
Message-ID: <1CF347E8-9262-4957-B7BE-0C22DBB30E63@lrz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 04
X-MS-Exchange-Organization-AuthSource: BADWLRZ-SWMBX05.ads.mwn.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2001:4ca0:0:f000:c013:adc0:ee3d:82af]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F455F26AC33D34A895CB91BD5A7D215@ads.mwn.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgZ3V5cywNCg0Kd2hpbGUgaW5zdGFsbGluZyByZG1hLWNvcmUgbmV3ZXIgdGhhdCAyNSBvbiBv
bmUgb2Ygb3VyIGNsdXN0ZXJzIHRocm91Z2ggc3BhY2sgSSBoYXZlIGV4cGVyaWVuY2VkIGFuIGVy
cm9yOg0KLS0gSW5zdGFsbGluZzogPGhvbWVfZGlyZWN0b3J5Pi9yZG1hLWNvcmUvMjUuMC1nY2Mt
bWF0bmNiei9zaGFyZS9tYW4vbWFuOC9jaGVja19sZnRfYmFsYW5jZS44DQpDTWFrZSBFcnJvciBh
dCBzcGFjay1zcmMvaW5maW5pYmFuZC1kaWFncy9tYW4vQ01ha2VMaXN0cy50eHQ6NDUgKGZpbGUp
Og0KICBmaWxlIElOU1RBTEwgY2Fubm90IGZpbmQNCiAg4oCcPHNjcmF0Y2hfZGlyZWN0b3J5Pi9y
ZG1hLWNvcmUtMjUuMC1tYXRuY2J6Znhyb2wzNmFjeXlhaGx4MjNmZ3h5YWZrNi9zcGFjay1zcmMv
YnVpbGRsaWIvcGFuZG9jLXByZWJ1aWx0LzhkZDM0N2EyYTVlZGM0ZmZkMThmOTIwNTkyMmZhMzVh
M2M4Nzc3ZTkiLg0KQ2FsbCBTdGFjayAobW9zdCByZWNlbnQgY2FsbCBmaXJzdCk6DQogIGNtYWtl
X2luc3RhbGwuY21ha2U6ODMgKGluY2x1ZGUpDQoNCk1ha2VmaWxlOjEyMDogcmVjaXBlIGZvciB0
YXJnZXQgJ2luc3RhbGwnIGZhaWxlZA0KbWFrZTogKioqIFtpbnN0YWxsXSBFcnJvciAxDQoNCkxp
bnV4IGRpc3RyaWJ1dGlvbiBhbmQgdmVyc2lvbjogU0xFUyAxMi5TUDQNCkxpbnV4IGtlcm5lbCBh
bmQgdmVyc2lvbjogNC4xMi4xNC05NS4zMi1kZWZhdWx0DQpJbmZpbmlCYW5kIGhhcmR3YXJlIGFu
ZCBmaXJtd2FyZSB2ZXJzaW9uOiBNZWxsYW5veCBUZWNobm9sb2dpZXMgTVQyNzYwMCBGYW1pbHkg
W0Nvbm5lY3QtSUJdLCAxMC4xNi4xMjAwDQpLZXJuZWwgZHJpdmVyIGluIHVzZTogbWx4NV9jb3Jl
DQoNCkNvbmZpZ3VyZWQgd2l0aDoNCidjbWFrZScgJzxzY3JhdGNoX2RpcmVjdG9yeT4vcmRtYS1j
b3JlLTI1LjAtbWF0bmNiemZ4cm9sMzZhY3l5YWhseDIzZmd4eWFmazYvc3BhY2stc3JjJyAnLUcn
ICdVbml4IE1ha2VmaWxlcycgJy1EQ01BS0VfSU5TVEFMTF9QUkVGSVg6UEFUSD08aG9tZV9kaXJl
Y3Rvcnk+L3JkbWEtY29yZS8yNS4wLWdjYy1tYXRuY2J6JyAnLURDTUFLRV9CVUlMRF9UWVBFOlNU
UklORz1SZWxXaXRoRGViSW5mbycgJy1EQ01BS0VfVkVSQk9TRV9NQUtFRklMRTpCT09MPU9OJyAn
LURDTUFLRV9JTlNUQUxMX1JQQVRIX1VTRV9MSU5LX1BBVEg6Qk9PTD1GQUxTRScgJy1EQ01BS0Vf
SU5TVEFMTF9SUEFUSDpTVFJJTkc9PGhvbWVfZGlyZWN0b3J5Pi9yZG1hLWNvcmUvMjUuMC1nY2Mt
bWF0bmNiei9saWI7PGhvbWVfZGlyZWN0b3J5Pi9yZG1hLWNvcmUvMjUuMC1nY2MtbWF0bmNiei9s
aWI2NDs8aG9tZV9kaXJlY3Rvcnk+L2xpYm5sLzMuMy4wLWdjYy01azV4dDdkL2xpYicgJy1EQ01B
S0VfUFJFRklYX1BBVEg6U1RSSU5HPTxob21lX2RpcmVjdG9yeT4vbGlibmwvMy4zLjAtZ2NjLTVr
NXh0N2Q7PGhvbWVfZGlyZWN0b3J5Pi9wYW5kb2MvMi43LjMtZ2NjLWtsbmdheGk7PGhvbWVfZGly
ZWN0b3J5Pi9jbWFrZS8zLjE1LjMtZ2NjLXdoZnFxeWo7PGhvbWVfZGlyZWN0b3J5Pi9wa2djb25m
LzEuNi4xLWdjYy1mbjRpeXliJyAnLURDTUFLRV9JTlNUQUxMX1NZU0NPTkZESVI9PGhvbWVfZGly
ZWN0b3J5Pi9yZG1hLWNvcmUvMjUuMC1nY2MtbWF0bmNiei9ldGMnICctRENNQUtFX0lOU1RBTExf
UlVORElSPS92YXIvcnVuJw0KDQpDb21waWxlZCB3aXRoOg0KJ21ha2UnICctajI04oCZDQpJbnN0
YWxsZWQgd2l0aDoNCidtYWtlJyAnLWoyNCcgJ2luc3RhbGzigJkNCg0KVGhlIGZpbGUgdGhhdCB3
YXMgc3VwcG9zZSB0byBiZSBjb3BpZWQgKDhkZDM0N2EyYTVlZGM0ZmZkMThmOTIwNTkyMmZhMzVh
M2M4Nzc3ZTkpIGlzIG5vdCB0aGVyZS4NCkJhc2VkIG9uIHRoZSBjb250ZW50IG9mIHRoZSBpbnB1
dCBmaWxlIChkdW1wX2Z0cy44LmluLnJzdCkgZnJvbSB3aGljaCA4ZGQzNDdhMmE1ZWRjNGZmZDE4
ZjkyMDU5MjJmYTM1YTNjODc3N2U5IGlzIHN1cHBvc2UgdG8gYmUgZ2VuZXJhdGVkIGl0IHNlZW1z
IHRoYXQgaXQgaXMgc3RvcmVkIHVuZGVyIGRpZmZlcmVudCBuYW1lLCBpLmUuLCBiMDAzZDE1YzU5
OWI1ZWYwOWFmMjI1MDhlZWVjMDlkNjVmYzkxYTRlLg0KSSBoYXZlIGNoZWNrZWQgdGhlIHByb2Nl
c3Mgb2YgZmlsZSBjcmVhdGlvbiBhbmQgaXQgc2VlbXMgdGhhdCBmaWxlcyBhcmUgbGlzdGVkIGlu
IHJkbWFfbWFuX3BhZ2VzIHdoaWNoIGFyZSB0aGVuIHByb2Nlc3NlZCBieSBmdW5jdGlvbihyZG1h
X21hbl9wYWdlcykgd2hpY2ggZG9lcyBzb21ldGhpbmcgd3Jvbmcgb25jZSB0aGUgZmlsZSBpcyBz
dXBwb3NlIHRvIGJlIGNvcGllZCBiYWNrIHRvIHRoZSBpbnN0YWxsIGxvY2F0aW9uLg0KDQpUaGUg
cXVlc3Rpb24gaXMgd2hhdCBhbmQgaG93IHRvIHBhdGNoIHRoaXMgdGhpbmcgb3RoZXIgdGhhbiBj
b21tZW50aW5nIG91dCB0aGUgbWFuIHBhZ2VzPw0KVGhhbmsgeW91IGluIGFkdmFuY2UgZm9yIHlv
dXIgdGltZS4NCg0KQmVzdCByZWdhcmRzLA0KUm9iZXJ0DQotLSANCkRyLiBSb2JlcnQgTWlqYWtv
dmnEhw0KTGVpYm5peiBTdXBlcmNvbXB1dGluZyBDZW50cmUNCkhQQyBTeXN0ZW1zIGFuZCBTZXJ2
aWNlcw0KQm9sdHptYW5uc3RyLiAxDQpELTg1NzQ4IEdhcmNoaW5nDQpSb29tIEkuMi4wMzQNClBo
b25lOiAgKzQ5IDg5IDM1ODMxIDg3MzQNCkZheDogKzQ5IDg5IDM1ODMxIDk3MDANCk1vYmlsZTor
NDkgKDE1NykgNzg2IDYwNSAwMA0KbWFpbHRvOnJvYmVydC5taWpha292aWNAbHJ6LmRlDQoNCg==
