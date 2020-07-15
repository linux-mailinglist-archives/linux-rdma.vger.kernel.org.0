Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3340D220CCD
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 14:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgGOMSs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 08:18:48 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:52264 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbgGOMSs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jul 2020 08:18:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 342924C8EC;
        Wed, 15 Jul 2020 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1594815525; x=
        1596629926; bh=XXM+lZQFy8POE4wsIX9ix3E28dERRBxBQlWdNo7c4WM=; b=O
        /4Z1+AjokSKyDBOyXEhIZ1ErCTDbJGmfX0K8hyIG66KnDvbbfS882+PhzgBR6Nru
        wbDwNiJzkwAoff8yB6TR/p8kdHPqlir9Y+EPzgznCoPX8ri3Ghq+0Hw6ZNHDwiS2
        14rQxk71ZT2VZ7mnjIBdlFunNSNU8+pPTJeGVCtKE4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hLkOJz_F16s9; Wed, 15 Jul 2020 15:18:45 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1D63B4C8FA;
        Wed, 15 Jul 2020 15:18:44 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (172.17.10.102) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 15 Jul 2020 15:18:44 +0300
Received: from T-EXCH-02.corp.yadro.com ([fe80::487b:cc6b:e67a:919]) by
 T-EXCH-02.corp.yadro.com ([fe80::487b:cc6b:e67a:919%14]) with mapi id
 15.01.0669.032; Wed, 15 Jul 2020 15:18:44 +0300
From:   Mikhail Malygin <m.malygin@yadro.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sergey Kojushev <S.Kojushev@yadro.com>,
        "linux@yadro.com" <linux@yadro.com>
Subject: Re: [PATCH] rdma_rxe: Prevent access to wr->next ptr afrer wr is
 posted to send queue
Thread-Topic: [PATCH] rdma_rxe: Prevent access to wr->next ptr afrer wr is
 posted to send queue
Thread-Index: AQHWWoX+jAiDNdOm80yPBeL7zUhTOqkIUV2AgAALdYA=
Date:   Wed, 15 Jul 2020 12:18:43 +0000
Message-ID: <6370C3FE-966D-4C6E-AAA1-179F39D382BB@yadro.com>
References: <A9F28BA8-EAB3-48AC-99C0-09E93D7B9DE0@yadro.com>
 <20200715113743.GC2021234@nvidia.com>
In-Reply-To: <20200715113743.GC2021234@nvidia.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.199.2.86]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7760A7FDC0FD934AA675F7D5CF46171A@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhhbmtzLCBJ4oCZbGwgcG9zdCBhbiB1cGRhdGVkIHZlcnNpb24uDQoNCk1pa2hhaWwNCg0KPiBP
biAxNSBKdWwgMjAyMCwgYXQgMTQ6MzcsIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+
IHdyb3RlOg0KPiANCj4gVGhlIHNwaW5vY2sgaW4gcG9zdF9vbmVfc2VuZCgpIGd1YXJhbnRlZXMg
bm8gcmVvcmRlcmluZyBhY3Jvc3MNCj4gcG9zdF9vbmVfc2VuZCgpDQo+IA0KPiBKYXNvbg0KDQo=
