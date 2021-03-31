Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03C635053E
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhCaRJz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 13:09:55 -0400
Received: from mail-co1nam11on2046.outbound.protection.outlook.com ([40.107.220.46]:50784
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229615AbhCaRJ3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 13:09:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mArW0fXEsNeDVISTQr0H9LGIzJtpUE/n7V/e4m3+C3LaGxR7r82bFfR5pplmD818TKqQXWid+Nyoah9mkOBVp/FZlP9modHtoCA+Jnjm1lfdwN21gB0DElWEmA+AoKdOU160T675+VfKz/JBYlVm4eOLfRiAUBUDfJlK3qkV2Pi10eJIJpKPF2bWnI2zUDSmR59p3Y/cINNjVgHcDTRkSFPIVjZWNTXQX3mr/6iE//y2cMChyn3trswOuBmdgcT+w6Nn2Dac8Rc0vEde1tyGz9fseSMg/vkIFHb+ponOJfPJnso4x4V7oM5SydwnOkvNXdsxbK5s2cVspdbvpDhYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uryrYNeNThEASQofpqiydyq+vcfoPJqMse0Up/mICB4=;
 b=mkqcAIyOugvXUzKc1DQoV8jGpUUNw9D2f6J9RNoQJYmMvdi+HVK2jOv0P/umycuuZdKZ2L+OedWxyECqA/GbYdC7voHTeEJdAHmHqOSJ2aRADYg6bJbJ2cPLMs1rIK4M2aUTjIv1OH6XA1evIyEE8a8gNmFuuSw5mrvzbstjkk2Pnv3gTzZh+NmLcwcAPO83enlPAxqZ7wS1GOUGx6nCPSeJEk3+ckRapXeeT99wuqpVDkxxCWFa9BZWs1R709Q8/VOyOBCGDY7aikdPX1PZrCB8nMhGii9vFswgT2hhGLZ4xtV2F0N4+hHmifvudPjKzTGNI4p+r3n6IIZrB6iNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uryrYNeNThEASQofpqiydyq+vcfoPJqMse0Up/mICB4=;
 b=JZr3ZeXwtrw+Ea+gSvVIItAmbpg1QVFp484cLsABg4Ntg6lL8N4C6/z0sKmRpSxjCvE+fm8X6+/Isq3XlvZOjCtMeYQTSt4GG3MQWOka8E1HYlXLd6YAUAlGgpeYbj9GSl1WYWI2nBPefUrA7qMOk94luLa165ch8nWzg4IFKmZjhpENsoO+T35Tt4LVPGkIZ/EZu51nP6jz9Oer/VKPW1wWIfxX9iCILbunIN9yW9ong7o1mfBc9CwQWlXUKumQVKcjPcy2ZY9YUxEyqJaNd3IS9//Ebrq6APK9EhYAcuUkAGl/Dcuy3tFyI/eBQ1XGsp/xvzzAdwpOPrOr3p/NJg==
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB3954.namprd12.prod.outlook.com (2603:10b6:a03:1af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 17:09:27 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::7cec:a7fa:db2e:3073%8]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 17:09:27 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Topic: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Index: AQHXIXfBOPltPxqzRUWWuvVXWh57HaqdMUWAgAC/pQCAABcXgIAAEDWAgAAErYCAAAU4AIAAAFYAgAAUwgCAACZI8A==
Date:   Wed, 31 Mar 2021 17:09:27 +0000
Message-ID: <BY5PR12MB4322EB01D0A22E6806B6F195DC7C9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
 <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
 <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
 <20210331131525.GH1463678@nvidia.com>
 <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
 <20210331133518.GJ1463678@nvidia.com>
 <E76F07B9-F222-4D0E-889A-712502DE0376@oracle.com>
In-Reply-To: <E76F07B9-F222-4D0E-889A-712502DE0376@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [136.185.184.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a88fd783-a008-4b81-a095-08d8f467bdc6
x-ms-traffictypediagnostic: BY5PR12MB3954:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB39542CD73813F909092A6A25DC7C9@BY5PR12MB3954.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rr2zF8FzxD5v1x+mDmFyi7fdqGySnGszmgn8wKgACTjd6hCOmPuRMtClf6HKouNFER7jAUP/zxM6VykeLt1TiBjvXE/R9ACSTYz+wdUIjpdyMhLO/6bLhomytFTXXBpBA0xF9oszpNTBQStISG5/PkhRIbk0LDHFQ5WJgKJ4MOabuBxUOFubQmi4ZSn/cyfDIWFAkxbNu/FCxvZpyDoMmhUgtEHqQAWnUjBOf9H8iaEwP4CD2Qo6QJhxZCMC3bopkaENGaC1eSZmHcRE4NWEfV/5Xh18d19hr5kcv7AoX1eDvo4B2+Fd/+9PHMONIeCVoLdgKMsc+H9W2cqkjD5xu+hxNUoEFh8Rk/GuXYBKa19zHmtQNvuLw9T0Zug8s7KbGa1NXy/dFfuDJB842QUG14FgVL3LWZxQLAGrtWbU8ClAHzb+MgFfH20nl/EJfpDfWYfWGjLu5buYssvB8zi6o7MxyFhyeyjI8ihirgldhhL6mGf+OVhzJP3RnybdirhmVT6C+kOKHvj3Ed5e1PQlGjKW0Wtz+zuyN3GRrFBK7q07oFHQ4VSWHxH7Svi9QQt2/GmpVfp64nkw56R+R7u+jBxkRfxwczCn4kbNqQogVG1ppJxlBaAqiBRsTIl9dsMg3dcLJlAwfV4WPQz1ZxiRijtG1x1TJ1ChSljJsg3Y/Nc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(316002)(66476007)(55016002)(9686003)(76116006)(2906002)(110136005)(54906003)(83380400001)(4744005)(478600001)(8676002)(5660300002)(38100700001)(71200400001)(86362001)(64756008)(33656002)(4326008)(52536014)(8936002)(6636002)(6506007)(186003)(53546011)(66946007)(66556008)(7696005)(26005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NkxsUkFGQjVJazV5RlhKcmJnOTUreGw4UStwbFRSZ2x3eHVid1c5Ukw5SS9m?=
 =?utf-8?B?WlhISXZzSEVrQnhmbnIzdXk1NnpxNFhMQUlmdzZuRXo4Zy8yLzFXVGhLYWhh?=
 =?utf-8?B?V1FoSnNkUDNFMmdqRHQ4MHpRZ3lWUVM1bTMxd1BRNlRiVmlmSDB4ZEcrUHZY?=
 =?utf-8?B?SWZXUWpIeDh5cjVIOVF2dmtteDh3MllXL0NSdThYSnZBNEFjWG5nem5haDl1?=
 =?utf-8?B?bXNDUjkwVjZyWGNJZ1RyMmFwcXNlYXdxRE9qdWYzeEM0NmxiQmxrR2tDaG9O?=
 =?utf-8?B?cE1uczRBbS9mdGhmanlaeXVPZDJGUmNVaEhnektQQ3VmRVJ3MUg3ZTJlY1A1?=
 =?utf-8?B?eCt1WjJwV0FwN28vQTFabVQwZ2dadEpDVnlUYklzT3JsVVZKd3NUVjE2aC95?=
 =?utf-8?B?TVdNL05pbDQ5VmZaenZWZFp5WWZKSHlWeElYdmdMWXg5NituTjRVLzFpbjMy?=
 =?utf-8?B?WndCendRQVM5cEFVeEhFM0dkeDZtNkdNTFlyRnU1YUw4cXJQdlRJbHFsOUsv?=
 =?utf-8?B?WnRad1lVOXUwaXlBZjNEaHQvREt2NWRqcE9hRitidi9nQWJ5TXV3U3N1VnpO?=
 =?utf-8?B?Mk44dmFHQzA4R0FQUU1vK0xJdlFBS2ZuYXZxUGR0Q203UDJ0VmY3Q1IvRmJR?=
 =?utf-8?B?SjNFVWJDd0ZyVFZBR2tWdEd0NmVITmtkQVBDTERhYnordmMrekZaNkhjNGhi?=
 =?utf-8?B?cWZ4cS9ZN211UTkwWTlwOEJRWGJ3eXViY0lyd3JydjQ3cGQ4eVA4bS83SGU4?=
 =?utf-8?B?REx6ZG4vaDJLYTRnNlIyNWtkbkZaTWQvQnBPM2Rzdis5NG9GVWlKak9yU1Q4?=
 =?utf-8?B?NnlmQWMvOUhNOHJJVG5meEZCWkVzcVd1SW1mM1JPMkVpbTJjay9QWnJaS243?=
 =?utf-8?B?bkhQYWNSUGtSOFAzZDVLb0lSeW8wK1E0bFZxSlorYTB4Vk8wMlhCMlNDSzdP?=
 =?utf-8?B?TW0yb29Ea1pKcTlmbXFPdUJjSmNRRXppS0E5aklIbW11ZlZ3L1NaanNEdVlm?=
 =?utf-8?B?cDJCMFlNR3AvOGNJYzQ4S3VtTXdlNXoxdDFkK0hHM2Y3REU2ZDloSnJ3bDRX?=
 =?utf-8?B?T0gyV01pcEZ3OTZDU3pJL0hwVHRxWUJTWlhqTzRxNGpSRitvOTd3ZTB0Q2F6?=
 =?utf-8?B?aXFraHV0a3hwdEhyWTd0K1YzRGpqa01iR1d0ZmZqa2QvME9jQlM1WjVwc3ZV?=
 =?utf-8?B?OFU1Zmg1WG5nNXhQK0NQZjY3OFBKSHhnLy9KL0FOVUdHbGpwNmE5dXJkNG9I?=
 =?utf-8?B?UC9yTUYwYkxtT2dqc2REZ21PRWR1NHR2U1dFbHNWSXFHd2Q1MEFuMk1sUlk3?=
 =?utf-8?B?bHUrYzlzbS8vTjIzYjVUay9FRVJkbmpBSmdIWC9WalIrV1BiMzhhWWs0VnBN?=
 =?utf-8?B?azEvcEtEQllNL3RvTU1ldUtGUzh4VGZOZFFoMjBvaFRyNkR5YUpPYjNIdUZK?=
 =?utf-8?B?Q3FSZXVRSDdTcGV1SUJCMGNiUlJjN1hGR1FvOXRPNDJPTEdSZWVUeG1FNElu?=
 =?utf-8?B?WjB5bVl5ckZFUmROYnl5c0FKeGRUcURhYnJOMGJFcFJSQzVxS3J5akVtRGJB?=
 =?utf-8?B?Qjc0S04rc29kNlRjQ2t4dGx2d2djMmVKeCt4ZUxJMTRvV2tRaDZlWVhQcVRz?=
 =?utf-8?B?a1V1QVZ5bFBremJwWXBpVUttVmE3aUhmaVJpa0UvY1N2MzQxa3BBNVpnVE5m?=
 =?utf-8?B?bEFPWm1ZMFZsT09Qa01RaW84eGpabHVWN3BaN2tpMjY4cnBKc0c5amhZNnZQ?=
 =?utf-8?Q?yW0k3wnKQEjIvPFzAZBxRYfS0aJJySwfeJbfqTp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88fd783-a008-4b81-a095-08d8f467bdc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 17:09:27.4609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ck2BkWR1fLgAhsDfYgv7ZIHbLIFmLouEzTR26v4o1FEnBixSJy9yEaYwX5ieNTnU3VwleEzlLkPJAC9jfwQpIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3954
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gRnJvbTogSGFha29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBNYXJjaCAzMSwgMjAyMSA4OjIwIFBNDQo+IA0KPiA+IE9uIDMxIE1hciAy
MDIxLCBhdCAxNTozNSwgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBPbiBXZWQsIE1hciAzMSwgMjAyMSBhdCAwMTozNDowNlBNICswMDAwLCBIYWFrb24g
QnVnZ2Ugd3JvdGU6DQo+ID4NCj4gPj4+IEFjdHVhbGx5IEkgYmV0IHlvdSBjb3VsZCBkbyB0aGlz
IHNhbWUgdGhpbmcgZW50aXJlbHkgaW4gdXNlcnNwYWNlIGJ5DQo+ID4+PiBhZGp1c3RpbmcgcmRt
YV9pbml0X3FwX2F0dHIoKSB0byBjb3B5IHRoZSBkYXRhIHRoYXQgd291bGQgYmUgc3RvcmVkDQo+
ID4+PiBpbiB0aGUgY21faWQuLiA/Pw0KPiA+Pg0KPiA+PiBUaGlzIHdpbGwgZGVmaW5pdGVseSBu
b3Qgc29sdmUgdGhlIGlzc3VlIGZvciBrZXJuZWwgVUxQLCBlLmcuLCBSRFMuDQo+ID4NCj4gPiBT
dXJlLCB0aGF0IG1ha2VzIHNlbnNlIHRvIGhhdmUgc29tZSByZG1hY20gYXBpIGluLWtlcm5lbCBv
bmx5DQo+IA0KPiBMZXQgbWUgc2VuZCBhIHYyIGRvaW5nIG9ubHkgdGhhdC4NCj4gDQo+ID4+IEZ1
cnRoZXIsIHdoeSBkbyB3ZSBoYXZlIHJkbWFfc2V0X29wdGlvbigpIHdpdGggb3B0aW9uDQo+IFJE
TUFfT1BUSU9OX0lEX0FDS19USU1FT1VUID8NCj4gPg0KPiA+IEl0IG1heSBoYXZlIGJlZW4gYSBt
aXN0YWtlIHRvIGRvIGl0IGxpa2UgdGhhdA0KPiANClRpbWVvdXQgdmFsdWUgZ29lcyBpbiB0aGUg
Q00gcmVxdWVzdCBtZXNzYWdlIHNvIHNldHRpbmcgaXQgdGhyb3VnaCB0aGUgY21faWQgb2JqZWN0
IHdhcyBsaWtlbHkgY29ycmVjdC4NClRoaXMgcmVmbGVjdHMgaW50byBjbSBtc2cgYXMgd2VsbCBh
cyBpbiB0aGUgUVAgb2YgdGhlIGNtX2lkLg0K
