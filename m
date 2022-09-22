Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51B5E6B82
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Sep 2022 21:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiIVTIL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 15:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiIVTIK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 15:08:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFCCFFA5B;
        Thu, 22 Sep 2022 12:08:09 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MIov0q028370;
        Thu, 22 Sep 2022 19:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=ylLuvsuh7Zk8/zZGkltpG+ALTMP3dX1kwoO/QEIaPl0=;
 b=iLv3NrWxLztktZjTbUvpm8YR3uXzId3iyxLA6hhXmEh+Rz9iZmRuM0rlzjax3dy9gKwO
 2Hsy6jCs5XkI/Unjg4X4+x85jDR6c8fk3S4uF9l1D44XmxFpXUyMu+AXofoBs80CXsWZ
 wGsYiF0elSZY3gS1DcwgiTf7TO6tUx5KLf2wW94tP2iIZsnfK3SqH59d0U8EmyYE7oGD
 Fh+/R1XS0pXbUcgKLwEYbMRx93AjEmzBWG6rk/9Nh/rQ7EyTd/niNffvNGDdRaF5H55L
 0Jh4iAmmYNjvgsof+f+ZoY2njpQKNX6dMozH74u+FJ3zJy4INvrWygqm3Ghq64AdYdTG BQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrv0uts7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 19:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzOrpKBBlfyQIGGN/9fJtRbRY9K7jXebH/TiVVTS6cgvPuHRuoMWfMqnIKPJ/OUNMbqFlB8fQF5USrp2bnWkGTzZrBUIj775sgZdGMfKTlK/UjEQ79v+38QbXIH6ko3GRFpdewCDFoDQBHjrZwLJZfrAgdkNLvAC0OeY1KV7QeBOxzxYE/RY1ibJ/kEDjshkSkWFAztsDxEc7dFHL23CecaMCbafagxOnM986EBY+HQb8RW/K/g8dAah+M2tnC9WoyyuGn+xbkTWQCzeOcf7jqfUHdG0clehbOwt5IwEigkpyKRcKKMBuEyVWtw3N/cthE4sL70+SonHDeA9OGWUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6ZKP21+LV3M8rgsKgpg+cdgpxxalkJvq26+4epmgk4=;
 b=RjO4gZapfY8jTrZo6Y/LhPSfQldJ0QPgK3sJ6daylIkAPRkCZOOeMCEbGE/HWvYPGIO4kxcqpERw7CNJ++5TWYgHTYG9cw55urUytfnMeBVhxtR9fGqe1/wNDCk9jAqsLYrM8VM3LvFSM7r9M6gCyFVvDPK6bwatyGTE4oN3t/eyLLmnNDf4TGDRN5BWyULAYYe+oeVyMRBXt6goQkeXdADgDDf5Fa4rNFzEQDuJU4SrHMlquKvy1tGP/amMuTjLYQdhRMz7vWP31//S/Wo//dgoK6rmZGtPXIAP7JXgFycEi7obTMmKy2/lITtyRSIUyRdJ00zABtjeu4jOqAw8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by BL3PR15MB5435.namprd15.prod.outlook.com (2603:10b6:208:3b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Thu, 22 Sep
 2022 19:02:55 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%3]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 19:02:54 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     jianghaoran <jianghaoran@kylinos.cn>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: Re: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT
 mips kernel when enable CONFIG_RDMA_SIW
Thread-Topic: Re: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT
 mips kernel when enable CONFIG_RDMA_SIW
Thread-Index: AdjOtcxhaPUgPb5HS4OBtI4lMFReCA==
Date:   Thu, 22 Sep 2022 19:02:54 +0000
Message-ID: <SA0PR15MB39191553A6C95FB96FAB7146994E9@SA0PR15MB3919.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|BL3PR15MB5435:EE_
x-ms-office365-filtering-correlation-id: 6c0019c8-4d28-4431-0c2c-08da9ccd0e5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AAndzaKgkgYRh2p7imINHpfhNMFS4cRHphq2wFuGwe8jCAEHG1D92JAF8cI9pT/ZKEHDhOwg/GNm+cCP2mW9M8W1GSPwVquuJKn+LCPIltDRZdtZzFapldXk7iEKKsqvj1o6HKRXjAKV5l9+/AVkiwpuF6UEtxte9AOX5iLK/VMOv5oCVOZyNuiK81167p8YsqHyu5XLHd1IqyiVFhm1L0E/3SWpRjhMrw/Z+mZjV2rERGlEif5YAgY1BPbXhJvxaGchELHaHOs+kBIQe+kukSkl1OgfoE5oVufSEHFLuBMxpWU+Rw37CclbcLVXcCl1yTICksVoqSqBdXTtHSpswtWA4WDjLn7I+g7bwaU3WTHt7lLKRvSsr+t6vCZlsj8XlNvr5MRIJMTKl/YD/CMA94FKUk0iXH+eyS6qjwaMjCJRGHOmhf+sk+J2UMvxa97aY43dTgN6DqJlK7aKAKTd8XyJDrkU036q03jm9B2ObZts4YBip/2KYk7QIugJbcCjtZcMrfQuYKrzrnv4CV1+J75KhNBdkVBMAAvve/gCSeF7Q7vG4iA4HhnnZdw3z+NGputDLrWkp5y2cwM8Y5XipSbznxUhYWKF0FkWFEt/Q+5y98za/9yPK5I/BQjZ/eRsGqlOEoktEG6ptV9rEPlxeks73f/FwBk2W38V38rq//3ADgyN7HhFD2ggXCE5c9Wugw4c9ddaqfQsIiFVCsW0+eTuVFZerrScUtjtqssspSGgY1gfQre0FDJBNY6XETAQNiax1xUOicbGIHgjJdA3z7th6gw6x9PsnUFRGLLdEdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(6916009)(5660300002)(52536014)(33656002)(83380400001)(76116006)(86362001)(8676002)(4326008)(66476007)(38100700002)(66556008)(122000001)(66946007)(316002)(66446008)(8936002)(966005)(6506007)(71200400001)(53546011)(41300700001)(7696005)(64756008)(54906003)(186003)(478600001)(38070700005)(9686003)(19627235002)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzA1RzFJUUsyMlV4VTE1cWw3OEYybWRRZndHaVNSYXlNOWV5YVVDbndPSXkz?=
 =?utf-8?B?aC9VUHZ4U01aUzlzSFdDNEQ3VlRlUDdQeTFZeks0ZkZFN0svVU1uMEpWOHB4?=
 =?utf-8?B?Zk9EcTRNSUh4c2MzZFhSZGdnMWlkaC9Bbi9wODRKdWx6eHJvdlZqYUFjaHB5?=
 =?utf-8?B?dzNVbnBEVzRWNTZZK0RqZWhTbjFWS2d3cEoza0luaTliNWtxVmsrc2g2ckZO?=
 =?utf-8?B?REdkV0pzVGNJM2pOTFkwekJEZ2h4RjNjQUJXK0NWdnk5QWU3cDcvUmhmWTVW?=
 =?utf-8?B?N3ZvbjRvZEFHa2FJOGZENWZBRm90bWFuc0t5eGM5YS93cE5WcUgvNTFvamg2?=
 =?utf-8?B?bldyVFBkWjcyVlBiMDhPbVMzbkZtbEYySktaTEJlY0d1clZZRi84ZzJJYlFn?=
 =?utf-8?B?MFRXT1FUZWQ3Q2RnNklxY2F5bThDZXJyVUNpWHlqczZwTTZzR3lwYkpjUjRF?=
 =?utf-8?B?N0Vvbit1RnJ3TFFYSzJRdkJTVnplWXM0eUJHd0JWcjZBWWhsTjVPeTBkV0FY?=
 =?utf-8?B?ZGFvV3BQREQyTTNtSWhXODQrdS80RVI0S1NIVDJjK2duQk9BSG1yYU92VGtz?=
 =?utf-8?B?WWtTZUNjQ1N3Ky82QWZjMzE3V3NaZkx4S3NMb0tPZ3cvcnJ2Uk5CRzd2clIz?=
 =?utf-8?B?K2xzdnB5dGFXdEVrZHE2TTdNUVU3VmNsMHNGdWlTWWc1bHRnOVNrSHRNcS9V?=
 =?utf-8?B?MS90QUdxNGNURytLeDlybEVHYXJoVlBNTk8vbkhCT3J3SkRnVHMxSkNJQWQ4?=
 =?utf-8?B?MWVmdlI2VCtkQzJBL1BtQXpMbys1NVBJQmx6V3BDSUtwT0N3V0pJb0JnWlh6?=
 =?utf-8?B?VE9yS0U4MExPMHQ4c1pUa29tUWp6UTk2WjVHTm1UTmQ2eXpGdHJ5M0k4YURa?=
 =?utf-8?B?Rk92aytVU1RLaGVBZ2FYU2FSYzFOYnBWVXVyT2FDUUk0YysvN28vZXVWVEhk?=
 =?utf-8?B?ZXUwNVpTKzA2cFByOGxsT3o5Z3M4ZzQrdzJqOEgzRU1pYlEzdittdTRaMk1s?=
 =?utf-8?B?N2hRV2NWTjQ4bDVNSnEwS1RSR2t4d3pXbU12OHUrZDVMalUwcWpsUklrbFZS?=
 =?utf-8?B?aDRTdWUzcnFRZklBRmYwZVVmSVhlNEpqVnpYUE5BbXQ5aVZremQyTlJMd1ht?=
 =?utf-8?B?MlY1NVd2VUhucUIyOHJVdVB3WjRGUTZZeEIyTUhNUmlEc3dtdVZKNzg0WXVy?=
 =?utf-8?B?OXB1TnNQMm9JenNFSjg2VFBZcUFtMmdZSmgzeWlYOEJtdWhiWTdnakNFVUgr?=
 =?utf-8?B?dk5naWRGeStwd1Z3eFlIeExCSENYOWZYeTlkTThUcnJQSHRqN092cXZZT0Ev?=
 =?utf-8?B?R0RVemROZWZwY0ErMzVZbVJpM2Fzb1dEaGRhb2VIQ1dTOUtrR1BsbFhhY3Jq?=
 =?utf-8?B?NmtGQnRlZ3lqclRjQmkydWJrUWpMRGE1aVdpMkc4V2J5L2lVMTR5eVpCRkRq?=
 =?utf-8?B?UGdwR1VwM3NPRHVDeE9hWFdYZ2ZGK3h2TTM1OE1jOXFtUXFrOTB3RVorQlpB?=
 =?utf-8?B?blNicXdzb25RWFQ0T01jbG11WWJwcEQ2VFBNN0hPZ25WUDJXTjMwU3p4RktD?=
 =?utf-8?B?cWZmVkVaUEhocWM4NVJILzFsUE1adGphN2dwdnFPUGFwN0lBbGxDYzNUNkdN?=
 =?utf-8?B?L09YengwNmVTYnV4SzBUNU5xNFY1UnZ2aURXYjdwZGRpdTI1V2NaNDdUckZL?=
 =?utf-8?B?c0F3MUQ2bDVyTkJVdVd5SjJUcUsxMVNoYXpidXh5WkFpU0p3S3lpR1YvRTJD?=
 =?utf-8?B?MDJjSER3VlVRblFkd1Jpc1ROODlKc1grcjJvcW50M3c3SHB3ckNiVklDTjBQ?=
 =?utf-8?B?cWpFd3BMWUM2NVQvQnFyOU8zeUN0MlBEeEEwYUdUWm9iZWNnOGhRUENqZU5t?=
 =?utf-8?B?dzZiSC9wWEpXSlVUV2F2QUhNUldwWEZGTEFLRFluaEpzZFhRQWFLeWlSTmRS?=
 =?utf-8?B?WU01aDlvOUJZZE1tTWQ1eWlEQVdHUXIyaGh1bW9oak1nWDY4UitiTjZrQW5C?=
 =?utf-8?B?NzA1TTFybXp2b0hQYmVWVzR0OTFKODFDZFhta3Z6R2xuUDFyTXVEWkpJMjVS?=
 =?utf-8?B?UU1SVkhEeWFJcjdYdndHekNJQjdwbXJoK0IyNmxKRzFxcjZQMVV5Z2k1d1U3?=
 =?utf-8?B?UDRDV3ZRZThhZC9OVVJrdGsrdzVneFlPc0tpRWZvd2wxOFRjVjVQdGUwbWJN?=
 =?utf-8?Q?LxUJAgQsG+1RaTH3DCTO2pozADvEMlGW/F0Bc4OWlzLR?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0019c8-4d28-4431-0c2c-08da9ccd0e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 19:02:54.9266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2THuAsMc0zcEuVBL0C4z33TdmNDEQJtUVvJW3mKXgze0yuowGJikO5liIlMj6Bzr5IOheI6ELZprzEuKZsnFow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5435
X-Proofpoint-GUID: YfP2WDw1TIMjwJ433AWLLPtAT9opHEPc
X-Proofpoint-ORIG-GUID: YfP2WDw1TIMjwJ433AWLLPtAT9opHEPc
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_12,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=969 spamscore=0 impostorscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDIyIFNlcHRlbWJlciAyMDIyIDE5
OjQ4DQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IGpp
YW5naGFvcmFuIDxqaWFuZ2hhb3JhbkBreWxpbm9zLmNuPjsgbGVvbkBrZXJuZWwub3JnOyBsaW51
eC0NCj4gcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IExpbnVzIFdhbGxlaWoNCj4gPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj4gU3ViamVjdDog
W0VYVEVSTkFMXSBSZTogUmU6IFtQQVRDSF0gUkRNQS9zaXc6IFNvbHZlIHRoZSBlcnJvciBvZiBj
b21waWxpbmcNCj4gdGhlIDMyQklUIG1pcHMga2VybmVsIHdoZW4gZW5hYmxlIENPTkZJR19SRE1B
X1NJVw0KPiANCj4gT24gVGh1LCBTZXAgMjIsIDIwMjIgYXQgMDU6MTc6MjRQTSArMDAwMCwgQmVy
bmFyZCBNZXR6bGVyIHdyb3RlOg0KPiANCj4gPiA+IFRoZSBjb21waWxlciBpcyBzYXlpbmcgaXQg
c2hvdWxkIGJlIGEgdm9pZCAqIG5vdCBhbiB1bnNpZ25lZCBsb25nLg0KPiA+DQo+ID4gTGludXMn
IFtQYXRjaCB2M10gd2FzIG1vdmluZyBpdCB0byB1aW50cHRyX3QgIHdoaWNoIEkgdGhpbmsgaXMN
Cj4gPiB0aGUgcmlnaHQgc29sdXRpb24uIFdlIHdlbnQgZm9yIHRoYXQgYWZhaWsuDQo+IA0KPiBU
aGF0IGlzbid0IHdoYXQgSSBzYXcgaW4gbWVyZ2VkIHBhdGNoZXM6DQo+IA0KPiBJTlZBTElEIFVS
SSBSRU1PVkVEDQo+IDNBX19sb3JlLmtlcm5lbC5vcmdfYWxsXzIwMjIwOTEzMTQwNDE2LjI4MDg2
MDk3MS0NCj4gNDBsaW51eGZvdW5kYXRpb24ub3JnXyZkPUR3SUJBZyZjPWpmX2lhU0h2Sk9iVGJ4
LXNpQTFaT2cmcj0yVGFZWFEwVC0NCj4gcjhaTzFQUDFhbE53VV9RSmNSUkxmbVlUQWdkM1FDdnFT
YyZtPVJ2Y3AtDQo+IEV2dmRPQ0VOTUYyczFsMWo1a3kzV1FxU2lKMF9ieTMxTkZEbnJRX2lETzZ6
ZWdHZ0xQeTRPaVFta0NPJnM9RlpPQmJBUG8wd0NKSg0KPiBSMF8wNjJfemM2aUU2V3lSc3p1M1E5
ZVV3dkE2bzAmZT0NCj4gDQoNCkxvb2tzIGdvb2QuIEl0J3MgdGhlIHJpZ2h0IHBhdGNoIGZyb20g
TGludXMgVy4gd2hpY2ggZ290DQptZXJnZWQsIGFzIHlvdXIgbG9yZSBsaW5rIHBvaW50cyBhdC4g
WW91IHNlZW0gdG8gaGF2ZSBsb29rZWQNCmF0IEppYW5naGFvcmFuJ3MgcGF0Y2ggZm9yIHRoZSBz
YW1lIGlzc3VlLCB3aGljaCBjYW1lDQppbiBhbG1vc3Qgc2FtZSB0aW1lLCBidXQgd2FzIG5vdCB0
YWtlbi4NCg0KV2hhdCB3YXMgYXBwbGllZCBpcyBMaW51cycNCltQQVRDSCB2M10gUkRNQS9zaXc6
IFBhc3MgYSBwb2ludGVyIHRvIHZpcnRfdG9fcGFnZSgpDQoNCkJlc3QsDQpCZXJuYXJkLg0KDQou
Li4NCkBAIC01MzMsMTMgKzUzMywyMyBAQCBzdGF0aWMgaW50IHNpd190eF9oZHQoc3RydWN0IHNp
d19pd2FycF90eCAqY190eCwgc3RydWN0IHNvY2tldCAqcykNCiAJCQkJCWt1bm1hcF9sb2NhbChr
YWRkcik7DQogCQkJCX0NCiAJCQl9IGVsc2Ugew0KLQkJCQl1NjQgdmEgPSBzZ2UtPmxhZGRyICsg
c2dlX29mZjsNCisJCQkJLyoNCisJCQkJICogQ2FzdCB0byBhbiB1aW50cHRyX3QgdG8gcHJlc2Vy
dmUgYWxsIDY0IGJpdHMNCisJCQkJICogaW4gc2dlLT5sYWRkci4NCisJCQkJICovDQorCQkJCXVp
bnRwdHJfdCB2YSA9ICh1aW50cHRyX3QpKHNnZS0+bGFkZHIgKyBzZ2Vfb2ZmKTsNCi4uLg0KDQoN
Cj4gSSdtIGNvbmZ1c2VkPz8NCj4gDQo+IEphc29uDQo=
