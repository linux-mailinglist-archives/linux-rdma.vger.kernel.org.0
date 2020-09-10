Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F5A264E7B
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 21:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIJTP5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 15:15:57 -0400
Received: from mail-mw2nam10on2130.outbound.protection.outlook.com ([40.107.94.130]:30689
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbgIJTOx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 15:14:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUSUgXGsXsePcX7Sn6FTvl6aSo1Dd+hVaa8AWcJRghqbBiQqOWEtqoq0CPeo4UyGfFdoGdSChp8KrGrMT0RjzJJqd9lCalqbkqUQXu5WtI1TKjNn9kheppcbcVnhV9fe2CFITlChdHB1bYk33m4WVeuvlHEsP7BkIh74/zf8YyVJmOjlciKB34C2RemzsZyphb/2g/NjzgXT9ED4aX7/hO6oTGo8ZIsANAY8OJGpsXK8UPj8g0P4Ql7iuI6BbPlm+bZXi0EF3mBgS1Ca2xynBoUiCJmQliRJuRvNWooynO9Y7EwZBfrOhw+V4Mmov5IYJFOlxXbwci0x6vdu3ECTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSFYAhpBSpRo1xM4FMzF2o9wxzGXLXgHJr0qSme1s4k=;
 b=HpB7a+5ZY7+ALUd77CkJvxSq5eI8DWa5svNhSCxIEFdZmDRS2RRZ45BD6vZJbWQRdnCjsLkL5LL6A4ZNeTkRTHGxHdt81ezCIRV8SDIdOOaa3aGp7fHCRz7Uph5ku+m6h4Azr8Qkiuds4N+Rq8aNkqPHf6PkraeSbHs55ak12sfgzWmDkq+YYAQBuEYltRJWG2uKlV2DFyyyU8YnyFN1Hm8s8IUwxJZI3dFFESSwVz4c8DlJF6iUEVOU9YGqIIYYsO8kS8alr19ZqUIA+2YARgm1eWK6R6NbgBGnRVlTpchp5SsVWasXNZ1iYoXIoZT8oMWLTtu+s1+S+5mKo+yQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSFYAhpBSpRo1xM4FMzF2o9wxzGXLXgHJr0qSme1s4k=;
 b=Jxm7XUlJ5E1r9iwG5cvAVcIO7LLzfU7CFfQnL03qr8uZJ0ixbODvLXVM9hSebtYeaBPmpLMqn1TsNG73jrYEhgGEkcYCww6yP75B1Jql44tJxllXm8VEX+Uwxhj8unnhx0uQiZEvBKFthVu8DEYrokPtoBYiqpOW8brR7uap+YM=
Received: from CY4PR1201MB0232.namprd12.prod.outlook.com
 (2603:10b6:910:21::21) by CY4PR1201MB0231.namprd12.prod.outlook.com
 (2603:10b6:910:24::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 19:14:50 +0000
Received: from CY4PR1201MB0232.namprd12.prod.outlook.com
 ([fe80::f969:46ca:793:4300]) by CY4PR1201MB0232.namprd12.prod.outlook.com
 ([fe80::f969:46ca:793:4300%6]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 19:14:50 +0000
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/iw_cxgb4: disable delayed ack by default
Thread-Topic: [PATCH] RDMA/iw_cxgb4: disable delayed ack by default
Thread-Index: AQHWhq/HJkpDy+3//UGG2qQaNwmNy6lgbiqAgAFgAYCAAHBAgA==
Date:   Thu, 10 Sep 2020 19:14:50 +0000
Message-ID: <CY4PR1201MB0232802345D9A7BC05F1B88DCE270@CY4PR1201MB0232.namprd12.prod.outlook.com>
References: <20200909134726.10348-1-bharat@chelsio.com>
 <CY4PR1201MB02327F3093F7DD29E08CCF32CE260@CY4PR1201MB0232.namprd12.prod.outlook.com>
 <20200910122739.GJ421756@unreal>
In-Reply-To: <20200910122739.GJ421756@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=chelsio.com;
x-originating-ip: [2409:4070:2100:d9ee:3c35:5057:f28a:6d30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b777ff7-4041-4ee1-0f83-08d855bdca69
x-ms-traffictypediagnostic: CY4PR1201MB0231:
x-microsoft-antispam-prvs: <CY4PR1201MB0231E074CAF1C146E97DEEA9CE270@CY4PR1201MB0231.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DSaBgY379hq3G/dIZoYfgs6oO1uXrum0Y2OkPGu5KDCdQ9bBK2Wyse8++03F7auWOb59VptWzXX1EM4AEh4osGERIE9+57g94a4klh3jv+jXnf2kYC8cJYLGBYg58qnKbnGqfyRFz/yClXX2iolvKUZ2Vf/9kJ4MQdfY0HT3KMXUjJlrty5GP1CkZH2NOdRaiTVPdFxl/fKlfsOzv+Swk9IhAFmHbRANZay+n4/C8q2Ek+oIwpUNDgVKbD2PSz7aaL73oGCb0mPI8/w/+a5/Jw12zbGY3pKmG2WKTFGzpqczoOTCJuLrwexszoZkWF+jkSYWbfZYl1hg5aqlLkclWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0232.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(366004)(136003)(376002)(346002)(478600001)(52536014)(2906002)(66556008)(5660300002)(66446008)(186003)(7696005)(64756008)(55016002)(86362001)(316002)(54906003)(66476007)(9686003)(6916009)(76116006)(33656002)(71200400001)(4326008)(83380400001)(6506007)(66946007)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pFxzC7GPbOesjiCCr4VkQDvTbF398ZDPIEhbVcwvmSOWO2KD9LCGiOIKugbKLgngrJS99HAyD+POjZvkC0umnksltIdmk8xT1zwe/XiNxfklXpgYye2zVkKqaHLOfXxrBvdC41sv+QJQMkYnVE8znuBkmnzmL61xMO2W+Xg/LRiUwDM+TJGVSy+0CcHxvtf0825eUK/Kk/JLo8NXO7vzoZQpkpQZ8PObKVHVonCEqSwkQ1RBN14CevAVTpivU2uhwrahDmlEGMDOTJm+P/dMrrgLZjoRPuDL4vGtXLguIA7TyXLziuR55v1ca8VQXBpZKO5JqA2fcZkAaPPqcgEUQiofGXtzaUXz1o35IFCieY36I6okM6YjEMsBOUSy0uKnOzV+jRLLElMv9Z6Ck6EaKKHpzdW0HzWxiEZUqcfNJdVPZEnzhv75yvllvP/Mtug7GHqdB7x/23Ul0FGAxjdnp2DukI98sJMNNjEJF9rmBMqzt0dlgIwxZynm66Z/9AakWplpjQEVyKHPnkDb1dN7jeQcKR3HwNhKVhdeRNSHOlhsBeb4tPEDTdhNMgb6FOsMjcYgIPHYYDdb11BSoH5K2g0jVOxsunX6EbKHvXq4MZpMkprkLfYm8wWlQlwYf5glLXiINyzzLQDpXfImqdXWCagcWiamwfiIL7VcvR8Cti+AIj2my0joZ7EpyoVrjbVKaJflUV1gJQNcK9YmKhZ39w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0232.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b777ff7-4041-4ee1-0f83-08d855bdca69
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 19:14:50.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4EKynjAbk7KKtL51IgZvO+L7QGhpKlxOmNldNl6ZNsV16O85tw0lRStQi43eIgUbQ9rytC6ZflS77JOKybhiE/r2rJW5F+M52jn2jmnuis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0231
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>> Subject: [PATCH] RDMA/iw_cxgb4: disable delayed ack by default
>>
>> Receive side delayed ack mode is needed only for certain area networks/ =
connections. Therefore disable it by default.
>>
>> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
>> ---
>>  drivers/infiniband/hw/cxgb4/cm.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cx=
gb4/cm.c
>> index 1f288c73ccfc..8769e7aa097f 100644
>> --- a/drivers/infiniband/hw/cxgb4/cm.c
>> +++ b/drivers/infiniband/hw/cxgb4/cm.c
>> @@ -77,9 +77,9 @@ static int enable_ecn;  module_param(enable_ecn, int, =
0644);  MODULE_PARM_DESC(enable_ecn, "Enable ECN (default=3D0/disabled)");
>>
>> -static int dack_mode =3D 1;
>> +static int dack_mode;
>>  module_param(dack_mode, int, 0644);
>> -MODULE_PARM_DESC(dack_mode, "Delayed ack mode (default=3D1)");
>> +MODULE_PARM_DESC(dack_mode, "Delayed ack mode (default=3D0)");
>
>Are you sure that this doesn't break user scripts?
Yes, I am sure. This does not interfere with user/kernel RDMA functionaliti=
es.

Thanks,
Bharat.
>
>Thanks
>
>>
>>  uint c4iw_max_read_depth =3D 32;
>>  module_param(c4iw_max_read_depth, int, 0644);
>> --
>> 2.24.0
