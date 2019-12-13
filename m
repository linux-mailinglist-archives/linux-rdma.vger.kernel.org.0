Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D2C11E495
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2019 14:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLMNaB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Dec 2019 08:30:01 -0500
Received: from postout2.mail.lrz.de ([129.187.255.138]:50563 "EHLO
        postout2.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfLMNaB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Dec 2019 08:30:01 -0500
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 47ZBNk4l2zzydc;
        Fri, 13 Dec 2019 14:29:58 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=lrz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lrz.de; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:x-mailer:content-language:accept-language
        :in-reply-to:references:message-id:date:date:subject:subject
        :from:from:received:received:received:received; s=postout; t=
        1576243797; bh=aeYOJQ6gjh9bFUmCPG+8ZO7AG0ummMo5lKrUMqs7mUI=; b=N
        Uf0UDm23/BZ0QwlR3lEAHcRy9b8PwokZePzcEagXGPKbeHxewH5kN1gzjbib1rsl
        emROg4pBT7G+I/dflcEiCDLmA/2ysPZJ5giV/nMHTBy1hfneLIH5BT+g//4gMqx6
        qBPAJ8hnqQGjth6lnGNKX4MJqvcVItYxyLLXzIlHCGZ5uhwWt+012q5ywJNFb5+G
        fDmfx2iGCGj/eVq7iK4AZlRFhJTp8y73o1NqIBEIecQi5Poh25x1RQ38WophytnU
        D+PRSugLhJrmJZ6Mlvo33Dv8FV7mOSR7wdWBw9y+InAZ/NKIojQ0GYzIo6i5dCPp
        Ecj84gWXfegjPwD2hV0+w==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -0.572
X-Spam-Level: 
X-Spam-Status: No, score=-0.572 tagged_above=-999 required=5
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
        LRZ_HAS_SPF=0.001, LRZ_HAS_THREAD_INDEX=0.001, LRZ_HAS_URL_HTTP=0.001,
        LRZ_HAS_URL_HTTP_SINGLE=0.001, LRZ_HAS_X_ORIG_IP=0.001,
        LRZ_MSGID_APPLE_MAIL=0.001, LRZ_RCVD_BADWLRZ_EXCH=0.001,
        LRZ_RCVD_MS_EX=0.001, LRZ_RDNS_NONE=1.5, LRZ_XM_APPLE=0.001,
        RDNS_NONE=0.793, SPF_HELO_NONE=0.001] autolearn=no autolearn_force=no
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id MCnf0y7bUYxp; Fri, 13 Dec 2019 14:29:57 +0100 (CET)
Received: from BADWLRZ-SWMBB04.ads.mwn.de (BADWLRZ-SWMBB04.ads.mwn.de [10.156.54.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "BADWLRZ-SWMBB04", Issuer "BADWLRZ-SWMBB04" (not verified))
        by postout2.mail.lrz.de (Postfix) with ESMTPS id 47ZBNj6M4BzydV;
        Fri, 13 Dec 2019 14:29:57 +0100 (CET)
Received: from BADWLRZ-SWMBX05.ads.mwn.de (2001:4ca0:0:108::161) by
 BADWLRZ-SWMBB04.ads.mwn.de (2001:4ca0:0:108::155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 13 Dec 2019 14:29:57 +0100
Received: from BADWLRZ-SWMBX05.ads.mwn.de ([fe80::4095:4fb3:50be:d2bd]) by
 BADWLRZ-SWMBX05.ads.mwn.de ([fe80::4095:4fb3:50be:d2bd%12]) with mapi id
 15.01.1713.009; Fri, 13 Dec 2019 14:29:57 +0100
From:   "Mijakovic, Robert" <Robert.Mijakovic@lrz.de>
To:     Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Problem installing rdma-core 25+ due to incorrect file name in
 rdma_man_pages
Thread-Topic: Problem installing rdma-core 25+ due to incorrect file name in
 rdma_man_pages
Thread-Index: AQHVr37FWWbKJMWIIkGy/PvNF3TeEKe4AxAA
Date:   Fri, 13 Dec 2019 13:29:57 +0000
Message-ID: <B7826F47-9BCD-421C-9292-ACC7711A3D74@lrz.de>
References: <1CF347E8-9262-4957-B7BE-0C22DBB30E63@lrz.de>
 <BY5PR18MB329888306491E78089EF2644BF550@BY5PR18MB3298.namprd18.prod.outlook.com>
In-Reply-To: <BY5PR18MB329888306491E78089EF2644BF550@BY5PR18MB3298.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 04
X-MS-Exchange-Organization-AuthSource: BADWLRZ-SWMBX05.ads.mwn.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2001:4ca0:0:f000:c096:d20e:6552:7584]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C212C7C1E4C9AA4ABEC13B348D051DC7@ads.mwn.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgTmljb2xhcywNCg0KdGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpSb2JlcnQNCg0KPiBPbiAxMi4gRGVjIDIwMTksIGF0IDA4OjE0LCBOaWNvbGFzIE1vcmV5
LUNoYWlzZW1hcnRpbiA8Tk1vcmV5Q2hhaXNlbWFydGluQHN1c2UuY29tPiB3cm90ZToNCj4gDQo+
IEhpLA0KPiANCj4gT24gMTIvMTAvMTkgNjoyNSBQTSwgTWlqYWtvdmljLCBSb2JlcnQgd3JvdGU6
DQo+PiBIaSBndXlzLA0KPj4gDQo+PiB3aGlsZSBpbnN0YWxsaW5nIHJkbWEtY29yZSBuZXdlciB0
aGF0IDI1IG9uIG9uZSBvZiBvdXIgY2x1c3RlcnMgdGhyb3VnaCBzcGFjayBJIGhhdmUgZXhwZXJp
ZW5jZWQgYW4gZXJyb3I6DQo+PiAtLSBJbnN0YWxsaW5nOiA8aG9tZV9kaXJlY3Rvcnk+L3JkbWEt
Y29yZS8yNS4wLWdjYy1tYXRuY2J6L3NoYXJlL21hbi9tYW44L2NoZWNrX2xmdF9iYWxhbmNlLjgN
Cj4+IENNYWtlIEVycm9yIGF0IHNwYWNrLXNyYy9pbmZpbmliYW5kLWRpYWdzL21hbi9DTWFrZUxp
c3RzLnR4dDo0NSAoZmlsZSk6DQo+PiAgZmlsZSBJTlNUQUxMIGNhbm5vdCBmaW5kDQo+PiAg4oCc
PHNjcmF0Y2hfZGlyZWN0b3J5Pi9yZG1hLWNvcmUtMjUuMC1tYXRuY2J6Znhyb2wzNmFjeXlhaGx4
MjNmZ3h5YWZrNi9zcGFjay1zcmMvYnVpbGRsaWIvcGFuZG9jLXByZWJ1aWx0LzhkZDM0N2EyYTVl
ZGM0ZmZkMThmOTIwNTkyMmZhMzVhM2M4Nzc3ZTkiLg0KPj4gQ2FsbCBTdGFjayAobW9zdCByZWNl
bnQgY2FsbCBmaXJzdCk6DQo+PiAgY21ha2VfaW5zdGFsbC5jbWFrZTo4MyAoaW5jbHVkZSkNCj4+
IA0KPj4gTWFrZWZpbGU6MTIwOiByZWNpcGUgZm9yIHRhcmdldCAnaW5zdGFsbCcgZmFpbGVkDQo+
PiBtYWtlOiAqKiogW2luc3RhbGxdIEVycm9yIDENCj4+IA0KPj4gTGludXggZGlzdHJpYnV0aW9u
IGFuZCB2ZXJzaW9uOiBTTEVTIDEyLlNQNA0KPj4gTGludXgga2VybmVsIGFuZCB2ZXJzaW9uOiA0
LjEyLjE0LTk1LjMyLWRlZmF1bHQNCj4+IEluZmluaUJhbmQgaGFyZHdhcmUgYW5kIGZpcm13YXJl
IHZlcnNpb246IE1lbGxhbm94IFRlY2hub2xvZ2llcyBNVDI3NjAwIEZhbWlseSBbQ29ubmVjdC1J
Ql0sIDEwLjE2LjEyMDANCj4+IEtlcm5lbCBkcml2ZXIgaW4gdXNlOiBtbHg1X2NvcmUNCj4+IA0K
Pj4gQ29uZmlndXJlZCB3aXRoOg0KPj4gJ2NtYWtlJyAnPHNjcmF0Y2hfZGlyZWN0b3J5Pi9yZG1h
LWNvcmUtMjUuMC1tYXRuY2J6Znhyb2wzNmFjeXlhaGx4MjNmZ3h5YWZrNi9zcGFjay1zcmMnICct
RycgJ1VuaXggTWFrZWZpbGVzJyAnLURDTUFLRV9JTlNUQUxMX1BSRUZJWDpQQVRIPTxob21lX2Rp
cmVjdG9yeT4vcmRtYS1jb3JlLzI1LjAtZ2NjLW1hdG5jYnonICctRENNQUtFX0JVSUxEX1RZUEU6
U1RSSU5HPVJlbFdpdGhEZWJJbmZvJyAnLURDTUFLRV9WRVJCT1NFX01BS0VGSUxFOkJPT0w9T04n
ICctRENNQUtFX0lOU1RBTExfUlBBVEhfVVNFX0xJTktfUEFUSDpCT09MPUZBTFNFJyAnLURDTUFL
RV9JTlNUQUxMX1JQQVRIOlNUUklORz08aG9tZV9kaXJlY3Rvcnk+L3JkbWEtY29yZS8yNS4wLWdj
Yy1tYXRuY2J6L2xpYjs8aG9tZV9kaXJlY3Rvcnk+L3JkbWEtY29yZS8yNS4wLWdjYy1tYXRuY2J6
L2xpYjY0Ozxob21lX2RpcmVjdG9yeT4vbGlibmwvMy4zLjAtZ2NjLTVrNXh0N2QvbGliJyAnLURD
TUFLRV9QUkVGSVhfUEFUSDpTVFJJTkc9PGhvbWVfZGlyZWN0b3J5Pi9saWJubC8zLjMuMC1nY2Mt
NWs1eHQ3ZDs8aG9tZV9kaXJlY3Rvcnk+L3BhbmRvYy8yLjcuMy1nY2Mta2xuZ2F4aTs8aG9tZV9k
aXJlY3Rvcnk+L2NtYWtlLzMuMTUuMy1nY2Mtd2hmcXF5ajs8aG9tZV9kaXJlY3Rvcnk+L3BrZ2Nv
bmYvMS42LjEtZ2NjLWZuNGl5eWInICctRENNQUtFX0lOU1RBTExfU1lTQ09ORkRJUj08aG9tZV9k
aXJlY3Rvcnk+L3JkbWEtY29yZS8yNS4wLWdjYy1tYXRuY2J6L2V0YycgJy1EQ01BS0VfSU5TVEFM
TF9SVU5ESVI9L3Zhci9ydW4nDQo+PiANCj4+IENvbXBpbGVkIHdpdGg6DQo+PiAnbWFrZScgJy1q
MjTigJkNCj4+IEluc3RhbGxlZCB3aXRoOg0KPj4gJ21ha2UnICctajI0JyAnaW5zdGFsbOKAmQ0K
Pj4gDQo+PiBUaGUgZmlsZSB0aGF0IHdhcyBzdXBwb3NlIHRvIGJlIGNvcGllZCAoOGRkMzQ3YTJh
NWVkYzRmZmQxOGY5MjA1OTIyZmEzNWEzYzg3NzdlOSkgaXMgbm90IHRoZXJlLg0KPj4gQmFzZWQg
b24gdGhlIGNvbnRlbnQgb2YgdGhlIGlucHV0IGZpbGUgKGR1bXBfZnRzLjguaW4ucnN0KSBmcm9t
IHdoaWNoIDhkZDM0N2EyYTVlZGM0ZmZkMThmOTIwNTkyMmZhMzVhM2M4Nzc3ZTkgaXMgc3VwcG9z
ZSB0byBiZSBnZW5lcmF0ZWQgaXQgc2VlbXMgdGhhdCBpdCBpcyBzdG9yZWQgdW5kZXIgZGlmZmVy
ZW50IG5hbWUsIGkuZS4sIGIwMDNkMTVjNTk5YjVlZjA5YWYyMjUwOGVlZWMwOWQ2NWZjOTFhNGUu
DQo+PiBJIGhhdmUgY2hlY2tlZCB0aGUgcHJvY2VzcyBvZiBmaWxlIGNyZWF0aW9uIGFuZCBpdCBz
ZWVtcyB0aGF0IGZpbGVzIGFyZSBsaXN0ZWQgaW4gcmRtYV9tYW5fcGFnZXMgd2hpY2ggYXJlIHRo
ZW4gcHJvY2Vzc2VkIGJ5IGZ1bmN0aW9uKHJkbWFfbWFuX3BhZ2VzKSB3aGljaCBkb2VzIHNvbWV0
aGluZyB3cm9uZyBvbmNlIHRoZSBmaWxlIGlzIHN1cHBvc2UgdG8gYmUgY29waWVkIGJhY2sgdG8g
dGhlIGluc3RhbGwgbG9jYXRpb24uDQo+PiANCj4+IFRoZSBxdWVzdGlvbiBpcyB3aGF0IGFuZCBo
b3cgdG8gcGF0Y2ggdGhpcyB0aGluZyBvdGhlciB0aGFuIGNvbW1lbnRpbmcgb3V0IHRoZSBtYW4g
cGFnZXM/DQo+PiBUaGFuayB5b3UgaW4gYWR2YW5jZSBmb3IgeW91ciB0aW1lLg0KPj4gDQo+PiBC
ZXN0IHJlZ2FyZHMsDQo+PiBSb2JlcnQNCj4+IA0KPiANCj4gVGhlcmUgd2FzIGEgdGhyZWFkIGEg
Y291cGxlIG9mIGRheXMgYWdvIG9uIHRoZSBNTCBkaXNjdXNzaW5nIHRoYXQ6DQo+IGh0dHBzOi8v
bWFyYy5pbmZvLz9sPWxpbnV4LXJkbWEmbT0xNTc1NTMzNTU2MjYzMTQmdz0yDQo+IA0KPiBUaGVy
ZSdzIGFsc28gYSBTTEUxMlNQNCBwYWNrYWdlIGF2YWlsYWJsZSBvbiBPQlM6IGh0dHBzOi8vYnVp
bGQub3BlbnN1c2Uub3JnL3BhY2thZ2Uvc2hvdy9zY2llbmNlOkhQQy9yZG1hLWNvcmUNCj4gDQo+
IEFzIHRoZSBTVVNFIG1haW50YWluZXIgZm9yIHRoaXMsIEkgZmVlbCBvYmxpZ2F0ZWQgdG8gcG9p
bnQgb3V0IHRoYXQgdGhpcyBpcyBub3Qgb2ZmaWNpYWxseSBzdXBwb3J0ZWQgYnkgU1VTRS4gSXQg
c2hvdWxkIHVub2ZmaWNpYWxseSB3b3JrIHRob3VnaCA6KQ0KPiANCj4gTmljb2xhcw0KDQotLSAN
CkRyLiBSb2JlcnQgTWlqYWtvdmnEhw0KTGVpYm5peiBTdXBlcmNvbXB1dGluZyBDZW50cmUNCkhQ
QyBTeXN0ZW1zIGFuZCBTZXJ2aWNlcw0KQm9sdHptYW5uc3RyLiAxDQpELTg1NzQ4IEdhcmNoaW5n
DQpSb29tIEkuMi4wMzQNClBob25lOiAgKzQ5IDg5IDM1ODMxIDg3MzQNCkZheDogKzQ5IDg5IDM1
ODMxIDk3MDANCk1vYmlsZTorNDkgKDE1NykgNzg2IDYwNSAwMA0KbWFpbHRvOnJvYmVydC5taWph
a292aWNAbHJ6LmRlDQoNCg==
