Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF2F4B752B
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiBOQx7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 11:53:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiBOQxt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 11:53:49 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E30D10782A
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 08:53:37 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FBOf7n005268;
        Tue, 15 Feb 2022 16:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=YNeoQ/DBvo/f64v6rQZELEO5PGvoCHgUlGgfpqeyLX4=;
 b=VUqto6MOtakOuJa81vaY/Jk/ezhI6aCyytIPqHTBRO+F2MGN6Ay44aTotGZyNh5R3HJB
 gGR5gTbSLNz4BlU5SUxOqYQ7PVDe2PA4wkUJOOEJ25NvtqTLx/NwK7EFd1FtTDpLfz2x
 PDy60F9T1guIde5NR2a6zgf9KZXhzqKiqIH3Xum1wGq451l2X5DnUxdoxtRjaviyo+G/
 l0WcXaYpdYmAzA14Ne1Z2NxbXmCwhMfm8gcoLe/G+Z3wiKxJjlZo0ftlW5VnukjI1c95
 rAsvKXt8smPpHcSlevWlPqShVC0L9EjRvLoWFPFrZ+f1QCYsBF96QU09WXlWAAGkxY2O 0Q== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3e8b92ttgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 16:53:28 +0000
Received: from G4W9120.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 57E2E57;
        Tue, 15 Feb 2022 16:53:27 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 15 Feb 2022 16:53:27 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.241.52.13) by
 G4W9119.americas.hpqcorp.net (16.210.20.214) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Tue, 15 Feb 2022 16:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAd0a/pwXGebOlAdVrjnjK00KiOO047jGOtk1cj9l0imUc6sMOhm01q5LPMV3wIod0sbfcsPuylaxGW/uMk0NTLASE2rrKdSh7tmvBggAZvE1TFp+RwPpam7UQfTnWi/BUsYlYSclKmC9Ye9XFtWYFtkfYziUqBejyTpxB8XIWeq0yeM1Q/NZy2B1+0vSM02WsT8R/KJct7uH7Bmh72eurCDU4F+BrST0KrGgkwLiuHC9Ycqo2+Sy4IKT1OFKBJAIEA62PvnWYvcA+UPJPGt7BfxHOIxjrtNGgPicjixkMnCcfdpVEQS1VqxTcaWJRfcu+ke4LI6rpONWLcY0JFO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNeoQ/DBvo/f64v6rQZELEO5PGvoCHgUlGgfpqeyLX4=;
 b=FdQat02oBOwMJ1ClCoyKJOPlSAIkSIlS+1kF2M6IFSJP10BbcWTQxwpZr1ksxljIlkeP9QmOpJAbUNpdSxEWllApyktepHAUROisUBfoo1tZsFytfkc6PZ/yiR0GQwcZ5MqSCfrkuUjmgGiCyqezYJqBhXuyYAabCzgPoTivVzlKcjxgpSISGooRR6u40WPspsxm+bSx7iHLyLD6VTmpRGg6ZM+WnORtmrafUMS4DN1x0+q4BWAI4RjZ4rAUWiiTAe/db10rnDzEYlosROYGvcmTC+MsdmtjVMSyW2ZcEDwT4j25OvLh9ISnbN90F4QzVDH/sv3asZ4K6WYkvhfjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::7)
 by MW5PR84MB2034.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 15 Feb
 2022 16:53:25 +0000
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8882:19f:abf:c173]) by PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8882:19f:abf:c173%5]) with mapi id 15.20.4975.015; Tue, 15 Feb 2022
 16:53:25 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Inconsistent lock state warning for rxe_poll_cq()
Thread-Topic: Inconsistent lock state warning for rxe_poll_cq()
Thread-Index: AQHYIczu9oQKWqycI0OU3v8E5biivKyThZ4BgACUwACAAJZngIAAHmvwgAAE1gCAAADeQA==
Date:   Tue, 15 Feb 2022 16:53:25 +0000
Message-ID: <PH7PR84MB14882185ED3BA2DEC460D894BC349@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
 <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
 <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
 <95f08f0e-da4e-13fb-a594-a6d046230d76@acm.org>
 <1f781fd6-a5e6-aa73-c43d-d16771fdef3c@gmail.com>
 <20220215144159.GQ4160@nvidia.com>
 <PH7PR84MB1488ADD314438A8EDEB5F219BC349@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
 <20220215164810.GW4160@nvidia.com>
In-Reply-To: <20220215164810.GW4160@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09cf0afb-cfb5-4eab-5429-08d9f0a3af03
x-ms-traffictypediagnostic: MW5PR84MB2034:EE_
x-microsoft-antispam-prvs: <MW5PR84MB2034D77ED3358F941764AD63BC349@MW5PR84MB2034.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k2hYIVYDD+M0vX3RIX6zvLuNlqyh9GDrPv0fEi2mhUtD9yA+VB0lfItFLBbokJ/b5i8AhzmP0ZeBWbH4/53HP+vsSzgXEOvy0L1385c65lbhMITirdqMpYcETSIdwR7ApQbUAnRw6lCbAJD68RUSfY3CHfYIJORPcn3CeFuE82gXvY8XghEQ3T0ekIRsxAbkp4LysU9KcjF7W7MWrzYnAMuhSiW0nMFKX41BV8KRdDChjv9QBeB0/wDjC9wJv9XVubYBXy5m7RqNQetNoVGk2doCCm5eU+Uw/4Nh9GX8Dwv9IWavfiEW5x+M/7PDQfFD5rm3kQCeZSYE5I3CsQxVvXlWxzQQOr9lQEm87sw6WnDLV3HaQgDSclzq7ETPuYx/oTkR7vuLpXR0jsQPdVMDVk2BTNfEzgRRpRjMptSBzov5iNqPFH+8IVSjmx0WA6PwqokryhyM2EpPmVPsYPrH/gguE/2ndpjfupkTBOPIPvwl/hkpQIF25a3BlI8YqN1EekQlJoUgP45x30TLCMYXyq1cGtxmBt4X1KxvLp6BShbCtXy6cLzRMj+jvbiA1pnAk+dM6RVFqQoA8WjFvgOuzrcI833GPg/tkaTEQOksNM5j0F7lKVlkXzlkozxZqow8NoUrKRBPdMbbhI+mB13ENZDEJzxseVNuuijh/lSM4bNQniK1iC5sOwz24uUQr+3UJjVXtMqP8yIFyuV9Zzz7IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(83380400001)(4744005)(76116006)(82960400001)(122000001)(5660300002)(52536014)(66946007)(8936002)(38070700005)(8676002)(66446008)(186003)(33656002)(71200400001)(66556008)(4326008)(6916009)(53546011)(508600001)(2906002)(9686003)(86362001)(55016003)(7696005)(64756008)(54906003)(316002)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AoFFp4ro2QOlrVOy7tYIHbKD45WO0O4kkb5XPsOY5upWTqMnvdAuJf9E4EI2?=
 =?us-ascii?Q?RbiJPkT4KOZLoRGsA1LGLevG+dtkxEOVg+yVcu6U8n+Rxvt0caTpX/L15PrC?=
 =?us-ascii?Q?RmjOq2R/oB9WRxD5l0f96MWuxpwGtFWZTGlV75pzz4GhrG8tmVrJzy8VaCjo?=
 =?us-ascii?Q?5MamrvLZO0GKDZbJLAdtb3zrfW9P9W9AlBIHF/beKWLPag4u407Eilt6S8ej?=
 =?us-ascii?Q?y5iHKObSoNVX0WigcXx1WBqfeFMNCMBT8AlkhqTufNHlvhW2cdRwpiVdVjiV?=
 =?us-ascii?Q?TAuCDOxLyz3ONdiGKVulJlPsQYaFP+lh8cE64jnpHeXCljkfz8KE/bZZT87R?=
 =?us-ascii?Q?d10O2fFYCM/WnDSTuMiQBy2Aw2uMIpLyD4NcGHPLmCg1XaonBLkgvgeCwCff?=
 =?us-ascii?Q?7sXvJ1z0PsQe9dFHlR5eVsGnfqHgLp68ubOPZm33QU5NPsimnuFx8uLAG0JD?=
 =?us-ascii?Q?TFuyBq27Ce/31ld7T+IeKBnZ8LTQkebg1eTOFRhAE/+rFw3IEHb/5QLiXBWc?=
 =?us-ascii?Q?lssOM8EJpwYylNax1/q/jHXBjMrWTAeFLXNbfrNGOSSjv57priG5N31aHDA8?=
 =?us-ascii?Q?t+b10R6QLdsHdSh4nXgqoUd7vmmgRMQxwuEzamvSaK0k9/ij89Jk4opuEgbR?=
 =?us-ascii?Q?VJ/k/wg0xVJS9KR88pSpQYtIwaskUaIuFLzRRRfEDFTonHFBL5T53FwKbAqE?=
 =?us-ascii?Q?K9i8CoSe8SYeNUGfckpSI45LKYuaMfcjM0KZUO7/8CtvEA/9LBE6AEQu9A+a?=
 =?us-ascii?Q?78dPwLB46lUQSQ95oMAaJrB9Z0XuLGmJQLzEPoG1VvFMvH+utbyOFuELy1Gn?=
 =?us-ascii?Q?0yBRBj790q3xZKvJyWwsRPLUpXGDJENIBlcGREH6X70htJN+Y9uGo0eXQSB0?=
 =?us-ascii?Q?N+Z0d2coW6SYP285mWZQyXccv8KQ3UmrRFzrBF6uyXc/JW4hovmDOV+0HJ6b?=
 =?us-ascii?Q?woaa701azAZs0HdUsEm6KRIc4OJn4Hhk5Sqm5BgBaulN/R5524dHbuaMEg6L?=
 =?us-ascii?Q?EvNawloH/RevYeiEkClmj1kwxRWtvvdOton8urSWaN+xvjbLivvB3JK4daK2?=
 =?us-ascii?Q?MqEShJRkB61skTtn49OEul4RyqfVuhePM98mr6E9ZXIvL/L0BV+3Np6zbPGK?=
 =?us-ascii?Q?Op6MvRUqHs6AcFnm1Yu6pyl6QgcQpPYkuDBdEjMOKJt+WvMVG+yPNmcm8zT4?=
 =?us-ascii?Q?F/gad7jMCcS+otHSkg3i00mPcZc6puXvXD6CxrMFeAbWBfs8qFpgTIGsrKvH?=
 =?us-ascii?Q?15qAjrLyZZyMxknpCqIIeHJVxAF1kSdcG0uLRLy7FhGRIvewacP8B/kKSv4x?=
 =?us-ascii?Q?+eR6oKhyBsbNfNWnc8NdyJFBodwqYT2o6FGsdYSxwIfGjsxbwCrRsUOl2m2o?=
 =?us-ascii?Q?OVzGqcmt/SJKfarwA0NoEzWs5WllVmw+qyPAVuKftfcTiJTTjAZF/eG6XxK1?=
 =?us-ascii?Q?Gnl4b6qn6rJL77TV0+eeAD/BQCJDASJ9cfDwZ6HGSSmYGqvdNIh0nAMVKYlv?=
 =?us-ascii?Q?QnV6oM1qim9uO3DMDmPhwhtMiRzWhMtvY7gUq66PxP9NoFepeiM7yTmnVoWI?=
 =?us-ascii?Q?bk8QSXJh3vKejWG9cyS0CipadODw/JWaE/1iFpXp5FwjnxF+d+vtRsjYU2oy?=
 =?us-ascii?Q?qp3rMjYNxjYUV+ajRMXkC4QNHbNbBTPJdbzuNVV50Q+U/ZVGLcSo7V/537o4?=
 =?us-ascii?Q?WYFon0WzZcY2HGe0qPBriVnZ8KA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cf0afb-cfb5-4eab-5429-08d9f0a3af03
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 16:53:25.4796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/yyqCdYJsnQM3YOBu/+c7K32xTRbKx3g1FgMZHT1q39Ab8DJy4FZ9xQgzHRcDOUq1G8/cKvABYhboHi8J3q0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB2034
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: n-nHrwrv4OrmyRpGbCaJRvaT-0Iz1EKv
X-Proofpoint-ORIG-GUID: n-nHrwrv4OrmyRpGbCaJRvaT-0Iz1EKv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=434 bulkscore=0 spamscore=0
 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150099
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Tuesday, February 15, 2022 10:48 AM
To: Pearson, Robert B <robert.pearson2@hpe.com>
Cc: Bob Pearson <rpearsonhpe@gmail.com>; Bart Van Assche <bvanassche@acm.or=
g>; Guoqing Jiang <guoqing.jiang@linux.dev>; linux-rdma@vger.kernel.org
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()

>=20
> >   spinlock_irqsave()
> >   write_lock_bh()
> >   write_unlock_bh()
> >   spinunlock_irqrestore()
>=20
> > Which is illegal locking.
>=20
> > Jason
>=20
Jason, can you tell me what the problem is with this. I'm not fighting it j=
ust want to know.

Bob
