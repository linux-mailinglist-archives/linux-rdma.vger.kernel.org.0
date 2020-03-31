Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9682F1996C7
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2020 14:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgCaMsE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 08:48:04 -0400
Received: from mail.vastech.co.za ([41.193.221.138]:48814 "EHLO
        mail.vastech.co.za" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbgCaMsD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Mar 2020 08:48:03 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 08:48:01 EDT
dkim-signature: v=1; a=rsa-sha256; d=vastech.co.za; s=dkim;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type;
        bh=h5uuofh10c0+qfw/gx9pG/pbn6G9sQZBSyN02yz7VD8=;
        b=Wb8zock57X4LLHJ/1zowGDT9dyqFjJd63DRN22cX/ekQ8RgQe82rdGXeOyLfFXjBMG5Sp5PyuDqUZt3jfgFhw9sJKswsoVStOrJ6aPfJl88MoPOodPhbsPLptjaOBzAzMHQhvD+PZFcnQD7X1t34sCS3BVreojstPEGZ5iDQRIc=
Received: from EXCHANGE1.vastech.co.za (Unknown [172.16.81.13])
        by mail.vastech.co.za with ESMTPSA
        ; Tue, 31 Mar 2020 14:42:07 +0200
Received: from EXCHANGE1.vastech.co.za (172.16.81.13) by
 EXCHANGE1.vastech.co.za (172.16.81.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Mar 2020 14:42:07 +0200
Received: from EXCHANGE1.vastech.co.za ([fe80::d871:63b9:9765:a9ae]) by
 EXCHANGE1.vastech.co.za ([fe80::d871:63b9:9765:a9ae%12]) with mapi id
 15.00.1497.000; Tue, 31 Mar 2020 14:42:07 +0200
From:   Jacques Marais <jacques.marais@vastech.co.za>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: ibv_send_wr untagged union 
Thread-Topic: ibv_send_wr untagged union 
Thread-Index: AQHWB1nJB+6VNbyQ3kqUIq5rOZ6QwQ==
Date:   Tue, 31 Mar 2020 12:42:06 +0000
Message-ID: <CC88D066-59C0-42D3-9C19-41D1D9FDF3EC@vastech.co.za>
Accept-Language: en-ZA, en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.16.0.58]
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha256; boundary="B_3668510526_1791544806"
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--B_3668510526_1791544806
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: 7bit

Hi

I have a question regarding a untagged union field added in commit:
https://github.com/linux-rdma/rdma-core/commit/f67fa98d3c0cb78c95f84301572eb93989d4b0f9

Specifically the union in the 'ibv_send_wr' structure:
https://github.com/linux-rdma/rdma-core/blob/master/libibverbs/verbs.h#L1097-L1100

We have a golang wrapper library in order to make use of infiniband in our system. However golang can only interface with tagged unions.

Is it possible to tag that union?

Or should I just send in a patch with it tagged?

Regards,
Jacques Marais

--B_3668510526_1791544806
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIPRwYJKoZIhvcNAQcCoIIPODCCDzQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggwKMIIF6jCCA9KgAwIBAgICAYgwDQYJKoZIhvcNAQEFBQAwZTEiMCAGCSqGSIb3DQEJ
ARYTZ3JhbnRAdmFzdGVjaC5jby56YTEbMBkGA1UEAxMSVkFTVGVjaCBTQSBQdHkgTHRkMQsw
CQYDVQQGEwJaQTEVMBMGA1UEBxMMU3RlbGxlbmJvc2NoMB4XDTE1MTIyMjExNTA1NFoXDTI1
MTIxOTExNTA1NFowgY0xCzAJBgNVBAYTAlpBMRswGQYDVQQKExJWQVNUZWNoIFNBIFB0eSBM
dGQxNDAyBgNVBAMUK0phY3F1ZXNfTWFyYWlzX2phY3F1ZXMubWFyYWlzQHZhc3RlY2guY28u
emExKzApBgkqhkiG9w0BCQEWHGphY3F1ZXMubWFyYWlzQHZhc3RlY2guY28uemEwggIiMA0G
CSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCbrAkspia5k1P5h+jpBPt9NRw0TtevUuPg+Cs1
eSONnLMUSFNVIPgcr1jlaDBXjlt9a5s1coZ34z90MrM9VJdVOig/SxhNovRbaEoKq7jq9mN8
YG8p5USYC1/Mkm8iNx5Qe+Bnioe4dcpTcpIIsYRfUTEGI+FSAuEAc8x9cbZCDGEqytDkdvTa
2a+8P94QBGLQayCXtBqR6NcB8Rfyg2W+fjjY9/yviBYZSwLWK1LUxsS72KNSgBDDgRVeVVvt
qEOPyTaBrDvSk/zlIpu2zZ1aQPa7bdLJWZllXuXw7ONqJimYljvJzbctmH6SyL7bPQfZD4x5
UrOeezbuwQzck1bC2lTeW2H9sIlh2DitaZx/Yxi9lhCofv2VIA6olkt6uDFrMhlIB22Hd0ch
bOwyQHMkkqP4i0E3kUQiL+JIljDqSd7uCK/6NyqZSMAjqSfoWBi7Vmemwv2GZiHMckYpjxVm
j88buL87arBf6toEXz7LK9Fiyb8ZyP9se5YXTVyE8kcGFPEi0C4JFb5loiZ55fVLpRj5DTfT
SmxpW/pS75Zf/Yzf0hRndki+Ztcb7OTozomB0MijUwoS6z8TU+HaqaeFfjlnUUTI/fm2YREe
geigtOAvbwujYACJvYi8/3YadMzvGrgZnyrjvT95fk3Vio2j/xz/h1LTIVLI0ZjqWwLqhQID
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
hfD3ktl19I0FuIMZjQUYJuQ/pRcOQZx18b4o

--B_3668510526_1791544806--

