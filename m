Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D863A2FDB18
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 21:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbhATUnD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 15:43:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43446 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731842AbhATU0s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jan 2021 15:26:48 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KJxWZW020291;
        Wed, 20 Jan 2021 20:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lQvhvbRjb4peCPtv/ZwGm9N/hHBLeifWQaYvfcGCON4=;
 b=wFJJ+KBX6nRHoOUb2SVbN47gIU8Lfd/n9u8HQCqHn8A9PUmnU8RhYj8Np1Vzsa3YqkYV
 QcGJate1spuNjMHwJkkjgITyg5oHVlmueI573Vx4vQ88sHDpDZLsQgbzddGf/71n1wqw
 vO33B0jJQ20EN8ho1H+qhXRbCljA2lsm06RJmXcr3aGOgVRhSNTogfdyqckucYy6ENeg
 One0peFIUcCeDgIPHrPhKhw13mAFx0GpWhpDgY87NVsQuxRcStGhWYDG/5S/N6ylNa3b
 N4rj7cTjpvlJIjUn+IZdKdcTeQ4Qa9sCA/WAFcRR4QA+PoqruifbvUvTEycq9/cItPi1 BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3668qacadv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 20:25:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KK0gJF135473;
        Wed, 20 Jan 2021 20:25:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3030.oracle.com with ESMTP id 3668qvv93u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 20:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq4QfNpwtqlgOwL58diAlAo+Pyw0eq6Qx23xz+Q+SI0hteMfUZKJ4oHoRxEo5l8Q6ndDqzXkRwbCauKPJJeAMLv289Yp1i+qO3CGah/oipZeLi7RnQ6OiG66grkpl2LHfqVw3XLxdnwX/Y2Q+CBsm+cPRIsxlnjiAMjRsPeU/WQAYMBhUFEghcCSHwAm5l5xyow2IGY6rJ07s+yKBX0SljYGvHmvycO4dt1mk3BzjfQOWeJArX+rRTW4UfClwRBIWJb6rnTc4Y7x/kBxrv+MuVoyF2KpjymNVjloYGkIdwpzN7tS5TzRRLW6HFlYesNV8sZDNwftobo6iq6/0Cdd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQvhvbRjb4peCPtv/ZwGm9N/hHBLeifWQaYvfcGCON4=;
 b=EBuvyjpHN0HNmp0JzZm4+jOJeiQw4E9QBjYQKSFix1+gPX1CwjFjCyK/6J1SKFOauIBHPL2IuqodG55WjoRF/hNpLwdkw4VHyXkDv76XiHJiiWDYyl+2LkbMa0G3jJ4Y5spC3m4NtlG2jl0QNqHwkYypPICwPQztYMz1uQmuu8fZ5D9pJea5HQ/sIMceaU4YrL7GI3MDs/qk+8yyF3n58+PB4JsCQw8GwJ9BE9OIl96VpapxMCoPIS9Z/hn/WaHgezDAbtwllulxVjMTPTtaoKMvMTtR7lueY3OVIqqnA4G/uNjLSLKQ4njGndGT3AWpRItSHPopgBVrIyFTkBNYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQvhvbRjb4peCPtv/ZwGm9N/hHBLeifWQaYvfcGCON4=;
 b=x9VOgnBWFcSBtdHSdnxZ+CuLMOWwdLMSNgFvt7E3JpNnW8ZrPw/Kh5bcviGS3YH1gmqAT2fQ9Dp5CApnN5KeClIgopBmpHFBu+k2veljSeYvrwe6VqzbCt46YmfnnekTiwVdape79qDwmbbRJNOkEA02ezGzer8xNo/6Y9VljBQ=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4386.namprd10.prod.outlook.com (2603:10b6:a03:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 20 Jan
 2021 20:25:43 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 20:25:43 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        "murphyt7@tcd.ie" <murphyt7@tcd.ie>
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
Thread-Topic: performance regression noted in v5.11-rc after c062db039f40
Thread-Index: AQHW7tKvBQQTuiJM7EWdlhiEV8dliKow9zMA
Date:   Wed, 20 Jan 2021 20:25:42 +0000
Message-ID: <A8F9F581-B997-4A6C-BE11-0D67EFDDC204@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <D6B45F88-08B7-41B5-AAD2-BFB374A42874@oracle.com>
 <0f7c344a-00b6-72bc-5c39-c6cdc571211b@linux.intel.com>
 <603D10B9-5089-4CC3-B940-5646881BBA89@oracle.com>
 <1107f22e-c01e-0dbd-4286-3a264b36e4e4@linux.intel.com>
In-Reply-To: <1107f22e-c01e-0dbd-4286-3a264b36e4e4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73cdab0a-b542-4256-45ee-08d8bd818f92
x-ms-traffictypediagnostic: BY5PR10MB4386:
x-microsoft-antispam-prvs: <BY5PR10MB438667E550D4D7B6ED2BB26793A29@BY5PR10MB4386.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIFB3w+CvHBkixh4PHsR1IanDH9D4f+bylbAtHIAcKR5Dbp62Fuizf5D/tHQs7IgLiX+ucMBQHZN+VQ5vNrQy5RTIf+FYY10zbSVuD/mlGAqhHUtBPGdgKiVM8jxE+B0R9kU7xCrwcooHpz/VgsI17ahXqxqRFw4NComh/1gTYIoxgWmRZft/p/ascBVg1VoiLUEm0u7gNTi6vRHuL8r8loJp8srYOcrcP9lmcTwBrC7tNrkOE9xjwCURijBl/riIlznsVJoaQ7xW2hkL+CFlUMSprOhf79XPcANGa0qs664qAIFyOfdxzSRWjkRpfRv4P285o3t7Nn2A2rDgbDLkTZ1iMg21zMHv3UF2Bhit7xjzIwfanCM8zOENaV+UadqfhCMBcBJblnimXXaEScZVdpTYYfvY8qQTo+97flLfPY1xlwbfDq3kvCKAiiXYOGBNVPtda32WFVLTGeyIbrgLxKYq9LuKKVBG9Q5hk+OYDI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(136003)(346002)(396003)(6916009)(66556008)(44832011)(186003)(2616005)(26005)(76116006)(33656002)(36756003)(54906003)(4326008)(316002)(6512007)(8936002)(71200400001)(53546011)(6506007)(8676002)(6486002)(2906002)(508600001)(66476007)(64756008)(66946007)(91956017)(5660300002)(86362001)(66446008)(98903001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eVYhqXNYDkDq2IenC3UnLWFGZ3WZidXSvVG56zFeIFCbkIFJR8Zi6r+O8MiN?=
 =?us-ascii?Q?uofhPQLSBEi/gfn+OEHQ2WCfLPu8wyBqhDtuq1JQWIqrFghhWfiDYmPgC2v7?=
 =?us-ascii?Q?RnB2dr6gizp/G5RxcaoOnMltohDu6slWdAX8WNAtZybkwSjr3W80u321nPA4?=
 =?us-ascii?Q?qq03hip6iiXVuwNcHVQ6C1HmPHGpFPhL1CW6oMeLl+CMnxoGfcxTuzKysfCE?=
 =?us-ascii?Q?ZV3EVcDaKxMl4KnHDnfedjeRqKMvxBOvUnGGsTW/JXk+JO3MY0iHooFfDM6C?=
 =?us-ascii?Q?eWYuwxp+B2+mRX4WSDdA5BXAKEjeVMClqP3MqAP5EUoYq7g60FZf2ph9aw0F?=
 =?us-ascii?Q?1LFb1J3P2kJA0GLDgeMEdLsFZ27QL4I5bLweNgMNB9KdyTbRZz2idi3jGxmR?=
 =?us-ascii?Q?/Ao13pRoYU2jaI1j7CM+LrffQPEYVAhZi7ApsP1Mj8B3iSlvOOM1yjdA2V29?=
 =?us-ascii?Q?/9001/8SV8fw5ID/SMfiNspLlZ80m1V3qW0qFxdXrS2BfVVx8F5i+3IxPK2j?=
 =?us-ascii?Q?I5ahTPO3ZJRd3dgdtMB/+BphQbq40wVVTNQ3jC+ygRALnFUIspKnBDxjrW6e?=
 =?us-ascii?Q?F9S7nxjBZLUBgjxcDJdYN9y9ZLivKDrp+aVPXJepxF37FT3n5Mx80b/49EIz?=
 =?us-ascii?Q?O1Y5BqUiHuPTHH7XaNcL8Wx3WGKVu55O572j/x7Y6//Yzuyip2e7fRjJUc7a?=
 =?us-ascii?Q?2xGDPaOSkjm9ZyHlqNInJ5YNsEWgzw7R14LlOzLDrz4lkjTuMuRu7ZsLIIpD?=
 =?us-ascii?Q?y3Gd7hHAWv9WpRHM/OSXk8waygK77smbEapQpTnGyb0mNzCPD86FROcp36Hq?=
 =?us-ascii?Q?UFmrgfh5YpN901QxcYNhhkSgQAmmMiHd+5yMnbptG5EbiBji1NXq8zbwIB/1?=
 =?us-ascii?Q?Q+podxtVQfmjs5mHhw/wBkuOixJqe2O6DjcIo4mhRK0k0VI27ICO6tGCcCOr?=
 =?us-ascii?Q?+fc2cOB+oc0vVkY2UeyKE3wh495Qp/B1pNcmtN/nxdJ/rhhQCXTmRqPf32gd?=
 =?us-ascii?Q?HAWN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BDABD7F2DD2AE24086F34020BDAD86DB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cdab0a-b542-4256-45ee-08d8bd818f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 20:25:42.8620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9ZvOlRQqmQ2yFvOdcEDO6PJglc93eU2DUZngsCJd8jCrzjovdYGpMKIY5KTqpEMK/giXEF+DT6FUPVDMz+LNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4386
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=935 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200116
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jan 19, 2021, at 9:11 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> On 1/19/21 10:37 PM, Chuck Lever wrote:
>>> On Jan 18, 2021, at 8:22 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>=20
>>> Do you mind posting the cap and ecap of the iommu used by your device?
>>>=20
>>> You can get it via sysfs, for example:
>>>=20
>>> /sys/bus/pci/devices/0000:00:14.0/iommu/intel-iommu# ls
>>> address  cap  domains_supported  domains_used  ecap  version
>> [root@manet intel-iommu]# lspci | grep Mellanox
>> 03:00.0 Network controller: Mellanox Technologies MT27520 Family [Connec=
tX-3 Pro]
>> [root@manet intel-iommu]# pwd
>> /sys/devices/pci0000:00/0000:00:03.0/0000:03:00.0/iommu/intel-iommu
>> [root@manet intel-iommu]# for i in *; do   echo -n $i ": ";   cat $i; do=
ne
>> address : c7ffc000
>> cap : d2078c106f0466
>=20
> MGAW: 101111 (supporting 48-bit address width)
> SAGAW: 00100 (supporting 48-bit 4-level page table)
>=20
> So the calculation of domain->domain.geometry.aperture_end is right.

I found the cause of the performance loss with c062db039f40: it was
a testing error on my part. I will begin looking at c588072bba6b
("iommu/vt-d: Convert intel iommu driver to the iommu ops").


--
Chuck Lever



