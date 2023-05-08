Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E5A6FA1FE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 May 2023 10:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjEHITp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 May 2023 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjEHITn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 May 2023 04:19:43 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 May 2023 01:19:40 PDT
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5472705
        for <linux-rdma@vger.kernel.org>; Mon,  8 May 2023 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1683533981; x=1715069981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wNJF6sIjt9CmhlkxOi8YRrwf+IwarqIlppu2cmXbyI8=;
  b=q86YwzyUMzOmeSaSGeq/wNLntlkeN7reGeqje1FYkswyvm7qytPoV19f
   fz2Hj8FWiwhkshGojy5iDn+fqMeHrNclAOd3MlwhS372tqpyBvfh4C7xx
   GRsgOM/IYl5JfPJfPNSgwtdRZFjQzdt13pNcjs6RMJGbUicgqfIDSSk8p
   NRWMF/v8mMZZn2G1U9j2r8ai9obpfKH9l4EK6R53j0aBxEqRCkTbD8nSk
   ADBIkkdgM9YEIJwsrGCGwD+tR74EJtz3hcryo0NhZbzu9g/zBpJAQJ4T4
   GfkbcJuH349rOHGU5gyUheM8PkCEo2PpJv1FR8FB7oPwVM9qv+4EKlPsQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="83620784"
X-IronPort-AV: E=Sophos;i="5.99,258,1677510000"; 
   d="scan'208";a="83620784"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 17:18:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdUgGFXrNUXDz2tZOjaFY0tNE/fNroi+zxvUMbn1tnJp5zkAhTmbFFHdy70gQLm8hyJPgh804aMQvl/lFpo498N+X8UEu2oDnKSfgFePjuJ/xEnfiqNWuYg1a9RYnlWTeu5GSNEi9FBdCoIReXmd8HlHFVP3TOrnBU6/GMBUcX609YRoujMNukvNMe2Sf0VZ0SvNsYI1+dwAFEVNj2pZU5G63OB7sHjMKPPtuwTnBroQ6o6GkCnf2tSJiQkUkn+qsbE5aRZOBERxeMzWfEaSeeUi0DfzQ4FWMu0hNqTPo8UtRY58p0aMdxmYQ2DjbkqVQZToIx70Vn3tYCWCp44PVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxE81H4MKPPECo7AtMhEOI2+9n2XRa2806jvIcv51lc=;
 b=PcbKjeV03nseJLLVeUAhAAWnCUjHHGAjW1/5jSALIiqKPn19VPgCxh1CfdYeOeqFwIvGxMsU498MlRoDeh+GsBYVxdIiCYJwoBRyKNOIscEZ3p/lFaCngsudvTsmIO1nx/ihFKDx+vdeFK6Vz/MLW+gj41Ddblrix/X/3hrIr3hkw7FtZMUY6AML/2byCmVnBUZ/N5GBHtKCs3qDBFdDG+J4Y6lMwry8fD0vACY93P4My5jjz0f+qP9R3Ak9sTQojR3z3wuNK1bAhGg62gnxkAYACga4njTwVO5iurjNrvp/QXeWTOmpVwXDa8hLFspKe4POPqJTCzt+0dnf2/Gxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TY1PR01MB10673.jpnprd01.prod.outlook.com (2603:1096:400:325::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:18:30 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::7a42:7791:f44a:5d0]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::7a42:7791:f44a:5d0%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 08:18:30 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Ian Ziemba <ian.ziemba@hpe.com>
Subject: RE: [PATCH v8 for-next] RDMA/rxe: Add workqueue support for tasks
Thread-Topic: [PATCH v8 for-next] RDMA/rxe: Add workqueue support for tasks
Thread-Index: AQHZefT1AEwMTtDg2Ui9JQCsNG1k2a9P0glw
Date:   Mon, 8 May 2023 08:18:30 +0000
Message-ID: <TYCPR01MB8455C2A4650E51FC4F2B8E94E5719@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20230428171321.5774-1-rpearsonhpe@gmail.com>
In-Reply-To: <20230428171321.5774-1-rpearsonhpe@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-05-08T08:18:29Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=9ec8e6e4-9a14-4094-b289-15316a1cca29;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TY1PR01MB10673:EE_
x-ms-office365-filtering-correlation-id: 3d739e8f-f192-4f1a-ec76-08db4f9ccef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 40n4sn0o1RpkEmK1uxdo8zHA7FGbS+f0Yz6VFHTRuteNY5oFYSN2Gtp/+Du3I/ppa41ljE3utXdmcTB4QLJ3OIJ3RhWeEXBzxzlnFFfF0FFWuDn7MTjipl+6jUgvUcxSwUMVD39tmipxoLDtUlKLOA3LSeQU/uUbFqGevGSdJKo29B52Vk9MF6npDyDoB3wVHH6jqGee2pQRgN5CMcdSs7gETxbZ2M6xwClzIrLHxlqp5Y7Odld5B4YI0U6Y8bglyR9aQa+8O+fZ6JQz/qSJTJxuBJd0i2O+TZeNXDuz970WsRfUCEaCtfHkFS0KQHYi0Ji1DHsfSJYNPcKcIJzDpEHFW9wytBa5ElJ/NXqBClqDOAXTdkDssy+ZhSttsB9z8GKeU25DllZZWRBpiyipHJU5+M+Jy9rmIJjFPDlVPzwmUzJnApMe9TjI6hiNjSmyWPCXOcobXtZu7TCo8a9mPT5SzIhztuWZDmek/vpvu64thisepJCersvTZ7hGnj9kRvVqXa4emmNzakGROgF++QyWv/fl+85naVPMqwF5TTWXrDakBc9E7YOKgSvtz1njumJlyy1xnrRMKh0QoQ5c1Ivk/OmW5N13G+5f4VuRLPPgvFcafysRPp4oa1FP/3H57JNanRluZqcpX4j3OuZouw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(1590799018)(1580799015)(33656002)(38100700002)(52536014)(2906002)(30864003)(38070700005)(8676002)(8936002)(316002)(55016003)(5660300002)(86362001)(85182001)(66946007)(76116006)(64756008)(82960400001)(41300700001)(66446008)(66556008)(66476007)(122000001)(4326008)(83380400001)(966005)(53546011)(186003)(9686003)(6506007)(26005)(7696005)(478600001)(71200400001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eFdJdEJSN1g2QTVLU05wVkxRQlFuNU9pRVJlcGJRSlptN3dKNzdnR2tp?=
 =?iso-2022-jp?B?dHlGWDFjWUhwTy9wSVNQeUtFUllPTXk2bEZScFFCUlFWNmNlZVAzYWFW?=
 =?iso-2022-jp?B?L3Awd3hSbkMzZS9iRFpUMHhmNlVUblREM1Q3RDM5NVFzZFBBSTV5ci9u?=
 =?iso-2022-jp?B?VjRmMklaS1ZibWRSRGk3T3BWWUJFUE9rb0tWcGxiOXhDNmR2VWFmbnBL?=
 =?iso-2022-jp?B?SzhWWndMUGVhL3Vwa0JvNy9ZMVIrOFpPajl5bm9jS01qMngxRUpWSkpK?=
 =?iso-2022-jp?B?MU5WdkdJbkFJc0VzK2QybUF3WW9ieUViZnhnZVg0STNMY1RYR21YNmNM?=
 =?iso-2022-jp?B?OVdZcHRyamE3U3pKZDlnTlRtZ1paTHRubnNYeDlEVldXRjJlMTVyYmVr?=
 =?iso-2022-jp?B?SU16WllsNlRtdkQ0Q1cxVEx5c0VJNFE2MEIva1ZwVlUzcjBXV0FhQlFx?=
 =?iso-2022-jp?B?d3grbDB3V0wrSHBDR1E0M2NzS2o0dXUydk10emZpKzB2UllQWHJjbWk3?=
 =?iso-2022-jp?B?ZUFpRkluYTRBMEdvUzRWUTEybjNHSjNpbGI5ZHpYSGxwYlg0M0F0Z1px?=
 =?iso-2022-jp?B?Q0V2YU1oQmN3MzZrMjdmTnFKMVZzcXhJMVdkdHlrck5jV1NnOWdybXlG?=
 =?iso-2022-jp?B?ZUNWeTBOYUtETnBLNS9HZGl2MTQ5KzRNNld2SGNHdlRzNWNha2xvak5h?=
 =?iso-2022-jp?B?R09RbGppT3Z6bWxXbFJ6UnlSZUE4TjFoQ20zRFMybWtEYjZnQlZLaXZT?=
 =?iso-2022-jp?B?QVY1V1d2aDdhb3VKTEFyL3ZYOG9pdVFqNUxNaDlScDUxMEVHOXJMbTR0?=
 =?iso-2022-jp?B?U1ZQNXRCZHN5NEZoWWRTMHVvR3NnZmR6QUovZlI2eVkwWFZJRXd5c2Ev?=
 =?iso-2022-jp?B?VTJTaTZXQ1h1NExMMDdWMGh1L1loQ2kvcTFOdVRPaXg3TEJxS1ZMWWEx?=
 =?iso-2022-jp?B?N3lyeVNQRGtOZkhiWVBXT2daRGxpVm1hYXh3VTBNTERJb3UzWUNLcTFy?=
 =?iso-2022-jp?B?WjFKQk9vNGpzTEpFdSs1ZTVpZkUwK0p0RFh4bUZqNEFkTWY3eWVzNGhH?=
 =?iso-2022-jp?B?WU5JSXJlVDR0K0tCWGlrRWlLOEpvdHRkMWN3WEkzUXdaSGp5QzRVYkl5?=
 =?iso-2022-jp?B?NEtlRW5KSWhQRDhyT2ZOa2I5NVBxZXl1Sjl2SU4rWCtjby9qZ3R2QnY3?=
 =?iso-2022-jp?B?d1IzSi9NbEF2NTJVUm5qZzdkMlRUOWhucHphQjUzZkIyRktEM0swSm9p?=
 =?iso-2022-jp?B?Ti9ONkZvMGdiL0FkNkhrY0tobXVaZ2lFQkRHek9xU3BieXlaYUxPRlJx?=
 =?iso-2022-jp?B?UVdkY0pmNFA3bFQxckZoOFdQVnZRcGt1UWU0R3hKS1BhblJkVS8yK1Jx?=
 =?iso-2022-jp?B?VUk2RHYyOW9DOWtXOXI3OVBrSEFQNG1Ca1dyNTBpK0VVWENsTEdoYXov?=
 =?iso-2022-jp?B?ZVR3dW44MXdDRWw0TzdSUW9vYXhsc3NsamdmVGpHRzdTNEVOV1plRVhh?=
 =?iso-2022-jp?B?NUs3djh6U2NiYnlSRkpzdUtDTXd4d3l2dVBXQWJuN3VENVJGeTJQSEl5?=
 =?iso-2022-jp?B?VTFUWGw2dXBKck1WMER1L2xOQzJYWC9EVHpJNDdGcXJVRm55d29GVHhM?=
 =?iso-2022-jp?B?REkzWStwS3pxai82a2dOd2lBVHl2MHNQdW1IVG5qVGtpaGJXVERjZC9K?=
 =?iso-2022-jp?B?ZEVoWlNnQTN0blRvU0tDSHZ5Y3pTSFNEeENKbW1OQ1BmNTdiNUxVeHJB?=
 =?iso-2022-jp?B?aVJiSnllWkJBdjdNVENxRGZtTEIzSG1wRHRFQTQ2TzdrWmc4TDJQaS9k?=
 =?iso-2022-jp?B?NktoTVNqYlZUMnJLTDJmaDBJZWtaYWE1Tmp3aUhIbmdIUFNOUG1oWDdk?=
 =?iso-2022-jp?B?VkdKaWs3WGQ3NExyaFJTNngxY0U1aldMNzV2OVltYytqSmkyNGFzSS9W?=
 =?iso-2022-jp?B?V1I5RDJCc3hLaExoZm1pYk5CKzUwbnFFV0Q1T2hTS3BwUUszeGJpUnZo?=
 =?iso-2022-jp?B?eFRwdjk4UlR5eHVzMnh1OE00ZVg4eTNMSExzQVpEeS8rOXloYzlUY3lY?=
 =?iso-2022-jp?B?OEhLUzdrQVpvS05wUzF1WlNmRzcxTWFzR1gxWXMycGRpdFg3QjNuV0s3?=
 =?iso-2022-jp?B?MlR2WW4rUEpnRG5uM0ZkM2M2VHFhTkNUVGdRT2dkamRra0liWmZSM3I0?=
 =?iso-2022-jp?B?UEdBN25rbTRBZXpNV3BRbnZWQTNLbE5XQVVXeU1ialZvNGVXYmJ5UGZV?=
 =?iso-2022-jp?B?cGlFMjZiZURGZ1FLSGxxbUJaS2tKenB0QTdQd0trbG9kaUxXaElFeDZD?=
 =?iso-2022-jp?B?ellNOEI1NGdzRWNGNDVjT01BVHFhSFVUaHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 14XPL+GDRoXtfVg2DEtOTDNB4Ja3hXhHbe6/wWDIpQSOUxSyvJq/LKENBNw+sl51QCczLcVEXsXij/8FtIclafKHYm0p+hVFE3RmvCcQGmtY3yB7hPXdJ3sZBrMD32jj7yWKtBAlvqFG8uqBiRZLt65waDMmpoEln2LZqeNnehtqmzfuvXWDxBBGLzqeHpVG5xkUOClWuMRVNqE5Dpd7slhAkhEzez9XVP0015YUeu5gLfiGwZvMGcXe3nqbOHO6bMlUVgf1bt85dBIL+wS41Oll/OJYNQOuxXmEa3c5wdrmhbG2zDPEtRQVGgmZB2LyYP/++hzyb0k33b1u11TVO7B4oalBQhURxpCbr5L6OThkosb3TpSzfNL+2pK0dANLzHNpcJyLDSqzexXTDBR4vCwo/HPZiEzUJfdsOSiU1E4EjxyOW8OORK/HdVoTsJQl7MGJif1YjqeCTMnk1iKAWQLx4JZ0zHD/3xn04xsvEC8J/lbFKjwP4VTyrIFv0C0oUG2j/qIjfRTmPJiC+ljqbM50yGoM0QVQXN5FXle/HEuu9xQ+MoFL9zJJXGtmqvvswB8tH0jVNgglKm3Kueab3G/ZWBHhjkXomyRS+UacoaMd7rLqCwEwtgTLCmCd2q8jwtdO80nPxo2BzYHz5RN6KLCkC3n4YlHJniS+U7srjT77n4kWug2+cf+FENgh6fD5F/WxTpLp9ZDvP5jxyR+vqq1oLOMhvDtAndUvXUvCRvad0aflz7VjPhnLWoJlfCN6eQNnZCFQ1J9f+a2lFOsSSkGSTGr3l9KtDb7sc+UDmkr/70jDC3knw0bmWRmLLZuRtnPyym22VRJG6V67aJ4RBt2a/uBtlFgPzxV0XdChm6w=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d739e8f-f192-4f1a-ec76-08db4f9ccef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 08:18:30.8426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgeYsVwIZdu9L5fPsnqERmjnGpgYkakUYBSWgonSZaHLlegs0z6JH9W7s5eTT8U4b5VOwEXdeA2JFCF0QDp2oQLTv635S8Cfo1aYegzw790=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10673
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, April 29, 2023 2:13 AM Bob Pearson wrote:
>=20
> Replace tasklets by work queues for the three main rxe tasklets:
> rxe_requester, rxe_completer and rxe_responder.
>=20
> Rebased to current for-next branch with changes, below, applied.
>=20
> Link: https://lore.kernel.org/linux-rdma/20230329193308.7489-1-rpearsonhp=
e@gmail.com/
> Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Sorry for being late. I've been away on national holidays.
The change looks good.

Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>

BTW, I have something to discuss, which is not directly related
to the inclusion of this patch. IMO, it should go into the tree.

Regardless of this patch, rxe responder currently *never* defer
any tasks other than RC_RDMA_READ_REQUEST ones. This means, under
heavy load, responder can keep on holding a CPU for a long time,
throttling other softirqs/tasklets in the system.=20

Here I show how it happens. When a request arrives on responder,
the task is scheduled if there is any task being processed.
=3D=3D=3D=3D=3D
void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
<...>
        must_sched =3D (pkt->opcode =3D=3D IB_OPCODE_RC_RDMA_READ_REQUEST) =
||
                        (skb_queue_len(&qp->req_pkts) > 1); // ### tasks ar=
e being processed.

        if (must_sched)
                rxe_sched_task(&qp->resp.task);
        else
                rxe_run_task(&qp->resp.task);
}
=3D=3D=3D=3D=3D
However, if there is any task being processed (i.e. state =3D=3D TASK_STATE=
_BUSY),
it is never scheduled but instead processed in the existing context.
=3D=3D=3D=3D=3D
void rxe_sched_task(struct rxe_task *task)
<...>
        spin_lock_irqsave(&task->lock, flags);
        if (__reserve_if_idle(task)) // ### this ALWAYS returns false=20
                queue_work(rxe_wq, &task->work);
---
static bool __reserve_if_idle(struct rxe_task *task)
<...>
        if (task->state =3D=3D TASK_STATE_IDLE) {
                rxe_get(task->qp);
                task->state =3D TASK_STATE_BUSY;
                task->num_sched++;
                return true;
        }

        if (task->state =3D=3D TASK_STATE_BUSY)
                task->state =3D TASK_STATE_ARMED; // ### used in do_task()

        return false;
=3D=3D=3D=3D=3D
This behavior is justifiable in that it improves performance. However, do_t=
ask() can
hold a CPU until maximum RXE_MAX_ITERATIONS (=3D1024) tasks are processed
at a time, and this can happen consecutively under heavy load. I would like=
 to know
what you guys think about this.

Thanks,
Daisuke


> ---
> v8:
>   Corrected a soft cpu lockup by testing return value from task->func
>   for all task states.
>   Removed WQ_CPU_INTENSIVE flag from alloc_workqueue() since documentatio=
n
>   shows that this has no effect if WQ_UNBOUND is set.
>   Removed work_pending() call in __reserve_if_idle() since by design
>   a task cannot be pending and idle at the same time.
>   Renamed __do_task() to do_work() per a comment by Diasuke Matsuda.
> v7:
>   Adjusted so patch applies after changes to rxe_task.c.
> v6:
>   Fixed left over references to tasklets in the comments.
>   Added WQ_UNBOUND to the parameters for alloc_workqueue(). This shows
>   a significant performance improvement.
> v5:
>   Based on corrected task logic for tasklets and simplified to only
>   convert from tasklets to workqueues and not provide a flexible
>   interface.
> ---
>  drivers/infiniband/sw/rxe/rxe.c      |   9 ++-
>  drivers/infiniband/sw/rxe/rxe_task.c | 108 +++++++++++++++------------
>  drivers/infiniband/sw/rxe/rxe_task.h |   6 +-
>  3 files changed, 75 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/=
rxe.c
> index 7a7e713de52d..54c723a6edda 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -212,10 +212,16 @@ static int __init rxe_module_init(void)
>  {
>  	int err;
>=20
> -	err =3D rxe_net_init();
> +	err =3D rxe_alloc_wq();
>  	if (err)
>  		return err;
>=20
> +	err =3D rxe_net_init();
> +	if (err) {
> +		rxe_destroy_wq();
> +		return err;
> +	}
> +
>  	rdma_link_register(&rxe_link_ops);
>  	pr_info("loaded\n");
>  	return 0;
> @@ -226,6 +232,7 @@ static void __exit rxe_module_exit(void)
>  	rdma_link_unregister(&rxe_link_ops);
>  	ib_unregister_driver(RDMA_DRIVER_RXE);
>  	rxe_net_exit();
> +	rxe_destroy_wq();
>=20
>  	pr_info("unloaded\n");
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw=
/rxe/rxe_task.c
> index fb9a6bc8e620..e2c13d3d0e47 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -6,8 +6,24 @@
>=20
>  #include "rxe.h"
>=20
> +static struct workqueue_struct *rxe_wq;
> +
> +int rxe_alloc_wq(void)
> +{
> +	rxe_wq =3D alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> +	if (!rxe_wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void rxe_destroy_wq(void)
> +{
> +	destroy_workqueue(rxe_wq);
> +}
> +
>  /* Check if task is idle i.e. not running, not scheduled in
> - * tasklet queue and not draining. If so move to busy to
> + * work queue and not draining. If so move to busy to
>   * reserve a slot in do_task() by setting to busy and taking
>   * a qp reference to cover the gap from now until the task finishes.
>   * state will move out of busy if task returns a non zero value
> @@ -21,9 +37,6 @@ static bool __reserve_if_idle(struct rxe_task *task)
>  {
>  	WARN_ON(rxe_read(task->qp) <=3D 0);
>=20
> -	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
> -		return false;
> -
>  	if (task->state =3D=3D TASK_STATE_IDLE) {
>  		rxe_get(task->qp);
>  		task->state =3D TASK_STATE_BUSY;
> @@ -38,7 +51,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>  }
>=20
>  /* check if task is idle or drained and not currently
> - * scheduled in the tasklet queue. This routine is
> + * scheduled in the work queue. This routine is
>   * called by rxe_cleanup_task or rxe_disable_task to
>   * see if the queue is empty.
>   * Context: caller should hold task->lock.
> @@ -46,7 +59,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>   */
>  static bool __is_done(struct rxe_task *task)
>  {
> -	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
> +	if (work_pending(&task->work))
>  		return false;
>=20
>  	if (task->state =3D=3D TASK_STATE_IDLE ||
> @@ -77,23 +90,23 @@ static bool is_done(struct rxe_task *task)
>   * schedules the task. They must call __reserve_if_idle to
>   * move the task to busy before calling or scheduling.
>   * The task can also be moved to drained or invalid
> - * by calls to rxe-cleanup_task or rxe_disable_task.
> + * by calls to rxe_cleanup_task or rxe_disable_task.
>   * In that case tasks which get here are not executed but
>   * just flushed. The tasks are designed to look to see if
> - * there is work to do and do part of it before returning
> + * there is work to do and then do part of it before returning
>   * here with a return value of zero until all the work
> - * has been consumed then it retuens a non-zero value.
> + * has been consumed then it returns a non-zero value.
>   * The number of times the task can be run is limited by
>   * max iterations so one task cannot hold the cpu forever.
> + * If the limit is hit and work remains the task is rescheduled.
>   */
> -static void do_task(struct tasklet_struct *t)
> +static void do_task(struct rxe_task *task)
>  {
> -	int cont;
> -	int ret;
> -	struct rxe_task *task =3D from_tasklet(task, t, tasklet);
>  	unsigned int iterations;
>  	unsigned long flags;
>  	int resched =3D 0;
> +	int cont;
> +	int ret;
>=20
>  	WARN_ON(rxe_read(task->qp) <=3D 0);
>=20
> @@ -115,25 +128,22 @@ static void do_task(struct tasklet_struct *t)
>  		} while (ret =3D=3D 0 && iterations-- > 0);
>=20
>  		spin_lock_irqsave(&task->lock, flags);
> +		/* we're not done yet but we ran out of iterations.
> +		 * yield the cpu and reschedule the task
> +		 */
> +		if (!ret) {
> +			task->state =3D TASK_STATE_IDLE;
> +			resched =3D 1;
> +			goto exit;
> +		}
> +
>  		switch (task->state) {
>  		case TASK_STATE_BUSY:
> -			if (ret) {
> -				task->state =3D TASK_STATE_IDLE;
> -			} else {
> -				/* This can happen if the client
> -				 * can add work faster than the
> -				 * tasklet can finish it.
> -				 * Reschedule the tasklet and exit
> -				 * the loop to give up the cpu
> -				 */
> -				task->state =3D TASK_STATE_IDLE;
> -				resched =3D 1;
> -			}
> +			task->state =3D TASK_STATE_IDLE;
>  			break;
>=20
> -		/* someone tried to run the task since the last time we called
> -		 * func, so we will call one more time regardless of the
> -		 * return value
> +		/* someone tried to schedule the task while we
> +		 * were running, keep going
>  		 */
>  		case TASK_STATE_ARMED:
>  			task->state =3D TASK_STATE_BUSY;
> @@ -141,21 +151,23 @@ static void do_task(struct tasklet_struct *t)
>  			break;
>=20
>  		case TASK_STATE_DRAINING:
> -			if (ret)
> -				task->state =3D TASK_STATE_DRAINED;
> -			else
> -				cont =3D 1;
> +			task->state =3D TASK_STATE_DRAINED;
>  			break;
>=20
>  		default:
>  			WARN_ON(1);
> -			rxe_info_qp(task->qp, "unexpected task state =3D %d", task->state);
> +			rxe_dbg_qp(task->qp, "unexpected task state =3D %d",
> +				   task->state);
> +			task->state =3D TASK_STATE_IDLE;
>  		}
>=20
> +exit:
>  		if (!cont) {
>  			task->num_done++;
>  			if (WARN_ON(task->num_done !=3D task->num_sched))
> -				rxe_err_qp(task->qp, "%ld tasks scheduled, %ld tasks done",
> +				rxe_dbg_qp(task->qp,
> +					   "%ld tasks scheduled, "
> +					   "%ld tasks done",
>  					   task->num_sched, task->num_done);
>  		}
>  		spin_unlock_irqrestore(&task->lock, flags);
> @@ -169,6 +181,12 @@ static void do_task(struct tasklet_struct *t)
>  	rxe_put(task->qp);
>  }
>=20
> +/* wrapper around do_task to fix argument for work queue */
> +static void do_work(struct work_struct *work)
> +{
> +	do_task(container_of(work, struct rxe_task, work));
> +}
> +
>  int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
>  		  int (*func)(struct rxe_qp *))
>  {
> @@ -176,11 +194,9 @@ int rxe_init_task(struct rxe_task *task, struct rxe_=
qp *qp,
>=20
>  	task->qp =3D qp;
>  	task->func =3D func;
> -
> -	tasklet_setup(&task->tasklet, do_task);
> -
>  	task->state =3D TASK_STATE_IDLE;
>  	spin_lock_init(&task->lock);
> +	INIT_WORK(&task->work, do_work);
>=20
>  	return 0;
>  }
> @@ -213,8 +229,6 @@ void rxe_cleanup_task(struct rxe_task *task)
>  	while (!is_done(task))
>  		cond_resched();
>=20
> -	tasklet_kill(&task->tasklet);
> -
>  	spin_lock_irqsave(&task->lock, flags);
>  	task->state =3D TASK_STATE_INVALID;
>  	spin_unlock_irqrestore(&task->lock, flags);
> @@ -226,7 +240,7 @@ void rxe_cleanup_task(struct rxe_task *task)
>  void rxe_run_task(struct rxe_task *task)
>  {
>  	unsigned long flags;
> -	int run;
> +	bool run;
>=20
>  	WARN_ON(rxe_read(task->qp) <=3D 0);
>=20
> @@ -235,11 +249,11 @@ void rxe_run_task(struct rxe_task *task)
>  	spin_unlock_irqrestore(&task->lock, flags);
>=20
>  	if (run)
> -		do_task(&task->tasklet);
> +		do_task(task);
>  }
>=20
> -/* schedule the task to run later as a tasklet.
> - * the tasklet)schedule call can be called holding
> +/* schedule the task to run later as a work queue entry.
> + * the queue_work call can be called holding
>   * the lock.
>   */
>  void rxe_sched_task(struct rxe_task *task)
> @@ -250,7 +264,7 @@ void rxe_sched_task(struct rxe_task *task)
>=20
>  	spin_lock_irqsave(&task->lock, flags);
>  	if (__reserve_if_idle(task))
> -		tasklet_schedule(&task->tasklet);
> +		queue_work(rxe_wq, &task->work);
>  	spin_unlock_irqrestore(&task->lock, flags);
>  }
>=20
> @@ -277,7 +291,9 @@ void rxe_disable_task(struct rxe_task *task)
>  	while (!is_done(task))
>  		cond_resched();
>=20
> -	tasklet_disable(&task->tasklet);
> +	spin_lock_irqsave(&task->lock, flags);
> +	task->state =3D TASK_STATE_DRAINED;
> +	spin_unlock_irqrestore(&task->lock, flags);
>  }
>=20
>  void rxe_enable_task(struct rxe_task *task)
> @@ -291,7 +307,7 @@ void rxe_enable_task(struct rxe_task *task)
>  		spin_unlock_irqrestore(&task->lock, flags);
>  		return;
>  	}
> +
>  	task->state =3D TASK_STATE_IDLE;
> -	tasklet_enable(&task->tasklet);
>  	spin_unlock_irqrestore(&task->lock, flags);
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw=
/rxe/rxe_task.h
> index facb7c8e3729..a63e258b3d66 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.h
> +++ b/drivers/infiniband/sw/rxe/rxe_task.h
> @@ -22,7 +22,7 @@ enum {
>   * called again.
>   */
>  struct rxe_task {
> -	struct tasklet_struct	tasklet;
> +	struct work_struct	work;
>  	int			state;
>  	spinlock_t		lock;
>  	struct rxe_qp		*qp;
> @@ -32,6 +32,10 @@ struct rxe_task {
>  	long			num_done;
>  };
>=20
> +int rxe_alloc_wq(void);
> +
> +void rxe_destroy_wq(void);
> +
>  /*
>   * init rxe_task structure
>   *	qp  =3D> parameter to pass to func
>=20
> base-commit: 531094dc7164718d28ebb581d729807d7e846363
> --
> 2.37.2

