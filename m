Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095E32207EC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 10:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgGOI5o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 04:57:44 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:36536 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727930AbgGOI5o (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jul 2020 04:57:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3E3D34C8EE;
        Wed, 15 Jul 2020 08:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:message-id:date
        :date:subject:subject:from:from:received:received:received
        :received; s=mta-01; t=1594803461; x=1596617862; bh=93mduM3MVkis
        VMobrsNrM56wiUgAkUM/bNbmiepK4Rc=; b=mxG8fJuv3Ij+CVFppQnDDqCysKYm
        XM6gsqQAiT/ywUtI6Btq7B1oUJ9Wh3idhRIiIj94Y4YusM+upjO0O56Dlfu2qs3Q
        O/WLdACkLmi2qxBMJQ9qtr4DGge22aUUwh1zw8J5TogD7mNWZ9v0xJ4FMDdG2Elw
        HSwVfbisGovHIcw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UgLXxw6m7OMz; Wed, 15 Jul 2020 11:57:41 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 34A3B4C89D;
        Wed, 15 Jul 2020 11:57:41 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (172.17.10.102) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 15 Jul 2020 11:57:41 +0300
Received: from T-EXCH-02.corp.yadro.com ([fe80::487b:cc6b:e67a:919]) by
 T-EXCH-02.corp.yadro.com ([fe80::487b:cc6b:e67a:919%14]) with mapi id
 15.01.0669.032; Wed, 15 Jul 2020 11:57:41 +0300
From:   Mikhail Malygin <m.malygin@yadro.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sergey Kojushev <S.Kojushev@yadro.com>,
        "linux@yadro.com" <linux@yadro.com>
Subject: Re:  [PATCH] rdma_rxe: Prevent access to wr->next ptr afrer wr is
 posted to send queue
Thread-Topic: [PATCH] rdma_rxe: Prevent access to wr->next ptr afrer wr is
 posted to send queue
Thread-Index: AQHWWoX+jAiDNdOm80yPBeL7zUhTOg==
Date:   Wed, 15 Jul 2020 08:57:40 +0000
Message-ID: <A9F28BA8-EAB3-48AC-99C0-09E93D7B9DE0@yadro.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE4BE9A574D7A24CA098BA517E60DBDF@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IFdoeSBpcyB0aGlzIFJFQURfT05DRT8gVGhlIHdyIGxpc3QgYXQgdGhpcyBwb2ludCBjYW5u
b3QgYmUgYWxsb3dlZCB0bw0KPiBjaGFuZ2UNCj4gDQo+IEphc29uDQoNClRoZSBpZGVhIGJlaGlu
ZCB0aGlzIFJFQURfT05DRSB3YXMgdG8gbWFrZSBzdXJlIHJlYWQgb2Ygd3ItPm5leHQgaGFwcGVu
cyBiZWZvcmUgcG9zdF9zZW5kX29uZSgpLCBhcyB0aGVyZSBpcyBubyBkYXRhIGRlcGVuZGVuY3kg
YmV0d2VlbiBwb3N0X3NlbmRfb25lIGFuZCByZWFkIG9mIHdyLT5uZXh0LiBIb3dldmVyIEnigJlt
IG5vdCAxMDAlIHN1cmUgdGhpcyBpcyBuZWNlc3NhcnkgaGVyZS4NCg0KTWlraGFpbA==
