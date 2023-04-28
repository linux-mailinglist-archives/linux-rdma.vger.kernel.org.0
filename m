Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15AA6F115C
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Apr 2023 07:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbjD1FiZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Apr 2023 01:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345054AbjD1FiX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Apr 2023 01:38:23 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Apr 2023 22:38:21 PDT
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777B11BD7
        for <linux-rdma@vger.kernel.org>; Thu, 27 Apr 2023 22:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1682660302; x=1714196302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hn2M6kUykbzHKHo8bjVXk3oxY9qKTqLMFtI763fff7M=;
  b=jO9qPhxQjIChROTOAKuUHKXZ53X2/Wgt7ToBSvvoPXWAjzMck9O/SLlY
   KIPzckwUWct58d0UwI6uLVbzYTGR7twVj5FAz82sYb6c04GeT8KvlAJ1c
   nvArtMqn4zQX0BYGtkICBZM4viqUji39D1jPnr6RvpX8gG/2LZrOgfGeQ
   W/Y5xKgtXt2nkQc3XhPxIA1QKEe3C54ctSlw1C2c2UAJKyjF3rpDX6DWz
   zdC3g+ecxUTYkQwxsBsM7St3pVob0utlySwX+1m/+4wPTTxTDYITAP4xT
   K1cKyq1kpvVqWinwe7aItQo2XL7jMOTCkO1Jye67fs42QiY8sgWGTDQuw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="83370551"
X-IronPort-AV: E=Sophos;i="5.99,233,1677510000"; 
   d="scan'208";a="83370551"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 14:37:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo42Ip/Dg7ukx8bPvijN/wdSClG/mjV6jifwb5s/6MmE/2gn6zWk1YmgYTQa8nusEi+Klw49+mkSmb6FDArEQ/+4Ph2AMVCGoZ3yebI2kxtc57rnk0TFABeCLpP26iATCPeROU5kZp/wsou1yjCu7Yi7oV3U99kmpSn7JZ/hPHYRAzcsVo4AC71X14sq6M0pAzuQAaPppumN1tuZR0n7Wuhrk6bGNRtofB9bcBgu92uFbcL23vO9S1YDVm5d/ZK6AR+RgwIsjVu8+2RkP5aNHA1fHB00J+KXIIVVqpNw1zHrJe5301AVBP+xI5YOWFym6Cx1o+e6enJyPveRlXxCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW+bFxyFa95lTqw4s/Cx2sUWUJ9MqmRZTA5TRtWVp+w=;
 b=El3W22PEzax74aAIqfKG9pCegvuXKaXsBPt/JHsWDGu/XJplfyjKlzvgdl8wM3GAwE9l5nUOlFF9zC3HtxZ+7War3CRc/HpLAAqHflsAcdNsvHY9lIGjSxHl94MLL+pckTsqd0iQSQcAI770We3QoBx0O/GORfFjxnHQfrEjGHlV96xQvHohmI4k0InxxhxKeM7DLuQ7N3FFiFLxEiZ952KIhypt7Jc32PfA/9DhFgANJqn8QbK5ZaWAq7IOnm7sOjeaOmvXGUpqhppkt2SVMIwmOrjvGcrI+6P10tlyyF7Le5KOG1xUaas5SmYtAkzOIM3R+jvqzVsPVSB5v1MZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OSZPR01MB7865.jpnprd01.prod.outlook.com (2603:1096:604:1b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 28 Apr
 2023 05:37:13 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::7a42:7791:f44a:5d0]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::7a42:7791:f44a:5d0%6]) with mapi id 15.20.6340.023; Fri, 28 Apr 2023
 05:37:13 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Ian Ziemba <ian.ziemba@hpe.com>
Subject: Re: [PATCH for next v7] RDMA/rxe: Add workqueue support for tasks
Thread-Topic: [PATCH for next v7] RDMA/rxe: Add workqueue support for tasks
Thread-Index: AQHZeSB2BlRVoXdhm0C+6OnAUHz2Ga9AKUZQ
Date:   Fri, 28 Apr 2023 05:37:13 +0000
Message-ID: <TYCPR01MB8455003F0BADEE220977C585E56B9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20230427155322.11414-1-rpearsonhpe@gmail.com>
In-Reply-To: <20230427155322.11414-1-rpearsonhpe@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2023-04-28T05:37:09Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=e36f5e17-e1c4-4782-b750-b6e2835bc225;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OSZPR01MB7865:EE_
x-ms-office365-filtering-correlation-id: aa1ec507-2429-481d-c511-08db47aa9e97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhIgFLczVIYFLxUKCz+oeIYJkPl4ohn6sLnQN4F2T08eO9Xb4kvFvUYj2YwQAuziVo0yoTpu8PWGnoE84IHHe0wJ+++AgBpqaStvSH83kZwhk5ASCCBb+2Hk1Fq+7enBVAHTYHeXIZB54iJtCy4pJKkT1h16Lre2NMUdlj6CoYiHyypslb80btQ2ZQCaU/yOjvylX//5donSW7a0WBVxCh65JqJTh2OKzH2x6dPN382+NIK/7a6RmAplXHvKuCQK8wUkVc4XBSk54AgGILE8fClQJTSXxNo110a64+jmhxOuRLdqN5YOD57RWQyJvKZAqrWiLuyb/6jGPfFixOxzT+VFL/Xyz+di95tEJOaGcBBuhON6s/p0uYYM6mplMbLOtf6A2QFQQt9bwh7gX+KjJ8Ip0h4pvc6z5SvF/B+mHOkDGe8VygGXFagt3hcGOek5Wp7Nz8WCiXbpqIHKTSbB7R6ZETz8zNeJUNWwLI8EJ3d9hRcN4OImvvJ4DFTGvOCcv1yOhDg6T01p2QJ1jz5ey4Qlui/gO+oH8p119UVt2AMBFbGS0VQxoFNTePvCycwDoFIzqx/nOL/iIzSJtOzv5LiQFQwj7vP3dBz7oBockWUwAd7agIZVBCbjPvtOm1Sq7lQwdX1/ICul+VXFAeBL5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(1590799018)(451199021)(110136005)(38070700005)(85182001)(33656002)(86362001)(8936002)(478600001)(82960400001)(41300700001)(122000001)(8676002)(38100700002)(5660300002)(52536014)(2906002)(66446008)(64756008)(55016003)(316002)(4326008)(66946007)(66556008)(9686003)(6506007)(53546011)(83380400001)(26005)(186003)(76116006)(966005)(7696005)(66476007)(71200400001)(1580799015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SzZuMk5uNmlZNFEzRks2SWVvVitKRnlOaFFQNngvQUdMWDM1REl6cWEw?=
 =?iso-2022-jp?B?dXlldzFpSjlMNCsvTmpqZVY5WlJNYnVjZmc1V1JkUlROaXRoUmhndlcx?=
 =?iso-2022-jp?B?TzNSV1R1MXcvdDE2Z2YyRU8wY0tzVHVreG5hb1V5TkJhT2d6REJ6aTlK?=
 =?iso-2022-jp?B?OUtlTjZQdkw2WFMyamJDQ1JVODR4b1MvYW5PcTlicGQ5Q3UwV0xhb1Uw?=
 =?iso-2022-jp?B?M3RhYTV3aVExbmxYWW1VZlBBK01hU0oyNjErV1MyZzdwYnllUGVFNnI4?=
 =?iso-2022-jp?B?K0dSMVVlYkdsUXVHWXdsREVTZng5eDlvWjdCeWRoQWkrMGJ0a3ZZZVRV?=
 =?iso-2022-jp?B?UXJkZkg3c01qZ3E0U3VvUm1hTWIzcnJRbS9jM3hqK2pXWENNWlM0bndI?=
 =?iso-2022-jp?B?SC9rWFhVeGVhY0Q1NTRqWjRCLzZ1dzlnRkh5T1NKR1hYeEplZWpVUHlE?=
 =?iso-2022-jp?B?c3RRNUhoM0NhYlB2dGIzQnNrWFRMZWl2alVYZ2RYcEZnazNyZDlFY2Ns?=
 =?iso-2022-jp?B?Nkx6NVB1WEVVM21oNW9sZUowT01OWFR5Ym1kaHNLTzh6Tm9rWjNCL1Z0?=
 =?iso-2022-jp?B?SXJmVkk1QXdvQzNoS2JYS1VsSDV4K2svWVZrc1FjZHRSZVRWUmh3SHo1?=
 =?iso-2022-jp?B?WFhjaWdSR0xtUDlkK2xBUmFwRGRJM01yZ3BOakRCYWlvbnhxTW9zTXYw?=
 =?iso-2022-jp?B?bVNGa20rL2xlYm5ybzZjRjY5bEJpN0FmNi85bEI1ZlZGQlRDQjZkeERp?=
 =?iso-2022-jp?B?WW1pd3ZxOUFZVmp2YTVHQ0JndklqQ3JEZWNkWUJCWEhVeEdQdzhXd2JJ?=
 =?iso-2022-jp?B?L0ozR1I5UEdrcGlsSllWRFE4N0RheHI0WmhJLy9iSHZzUzlGNmVzNTJL?=
 =?iso-2022-jp?B?aEd1NUZadTZBQ3UzeE1IeWNEK2ptM2dLVDNIRlB5ZC80WWRid3pWY1JU?=
 =?iso-2022-jp?B?UFg4bGZjR3JxMmZkVVlPc3pxM3o4VlRUQm8xVUE3ZTcyK01mbWF5b3VF?=
 =?iso-2022-jp?B?NnR1eFNYSzk0cHV0clBPa2FhNC9TWFE2dStvMXc2K1dsOHpOa0t0Ym1o?=
 =?iso-2022-jp?B?cThOVWpwYW1zOHVEUEVWR252MGFoem1LYkJpSVhWYUJ5Q3RPcjh2RUlS?=
 =?iso-2022-jp?B?QzJmVzdXd01YTnZpYnF2SnVYSFpOaUk3cVN3OWZRVGd0L0xERlNBR3R0?=
 =?iso-2022-jp?B?VXduU09vcmNMVlI0K1dKamVHZmdKd2NaSGxDd2FmYWdtTTR5SkNFQ1Jk?=
 =?iso-2022-jp?B?Z29mbGhMc3l1bTFhQlpUbStlVnVtZmVKZVZOK2svS05EMC9xZWoyQjhq?=
 =?iso-2022-jp?B?eGRycTRPeTFidk5WSGdRbXdzaStxd1h2ay8rNTFJcEFHMWtwT2ZlMDda?=
 =?iso-2022-jp?B?dFNzWUZkSlJ0OFVIeDF3Rm9sTHhQdzNVZ0ZENnl0SWxiQXc1MVFUUllD?=
 =?iso-2022-jp?B?azJlL3JIb2YvMHV6NmhoQitiNmpRMVNXQnpaYTJpSFRKY1docjVFQ0U4?=
 =?iso-2022-jp?B?TGxkd2lMa2NnekM2dFZsL094WGdxUlpVQ0NGcTQ0clhRb29SeG1SbnM2?=
 =?iso-2022-jp?B?YnR5ZVNLOHg2eFZvRVNocVE4VHo3dlJyU0J6TnlpR2hzZzV6MjlYOU1W?=
 =?iso-2022-jp?B?MTFTOWpCelo2NUducy9IcWFwSlk4ZWNvRGlIR3hPdndJYjFlMkRXaG5M?=
 =?iso-2022-jp?B?bFdLN0RSK2V0Y0hIa1VwZk41UEw4Ty8ySWhEVDVDUUV1ejU0ZlRBdld1?=
 =?iso-2022-jp?B?YUM0WjNJNHN5U2UyWGVzU3krTlZkQ3dhbkFtKzFGYjE4cTB0Z3puQmhC?=
 =?iso-2022-jp?B?VWV6V0JDV1V4WTE2cEpCWlZkdUtUSTZJWjd5ZjdIWlFnWXNodjBLMjgx?=
 =?iso-2022-jp?B?RzRkWm9lK2JyZlg1VWZRTkkwRFo5R0ZZNUpGTFAyMXE4NlR6cUZoeWNi?=
 =?iso-2022-jp?B?VEpXTmZVYXlhVXl5RjIrZmUrRHorU1ptZFQ2b2wxQXJ5Lzk0ZWJkZDhh?=
 =?iso-2022-jp?B?YjE2eVlxZUJ2Mm9oMUxqRUlHMUhCVDN6dUJ3ZVNyWFEwTjVTM2UvWDRM?=
 =?iso-2022-jp?B?MnM1TjZLcmtWTStZd0tvQzdpSFZ4UmU3cEJLdHJpSzB3VWMwczZRQW1l?=
 =?iso-2022-jp?B?RytFekNTRkF6anBJTm1LUlRwK3pCd2doVnB5MGEzU1Ixbno3RmwyblVx?=
 =?iso-2022-jp?B?NlJjOGtybFZBU21NYWJqVVFNcWdtZDdzaUZHQnl6eFBWbEo4b1VDUERV?=
 =?iso-2022-jp?B?YzhxSVZPZStNWlJtdUNxRGRhUzJNNExuRjMvbitvakdBKzE4RTh3dWlH?=
 =?iso-2022-jp?B?SnAyY0E4YmROVUlXdXVvaTRsQUttM01JeVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M2KzaUXrsWZ/NU03OxrWxm+CJxz6wjoFSjrYE5u7R7bfn6zCPZ7/cB/xMpNX7ugQrMIzdK6AJf5cSsPMDXbqwkTVgfhn+ZXNUXlmGW4h9IV7SDQ/9evUZOO5swqcq7GvpKqccoyN5l5uSBxDEfr0Ihga3Llwz4tG8A5kBAj7oxCokOZSQaCEkyVXmQlwHzjCLFDFhcEofvBnnyvqNjICFJrS4avH3yPDmG8xrXNTN2WbSaZZ3VyvxG173/9238jK1dvGhWIP+X7xCzgg33M7R9PQcoPf67+Qlrv8n12Rfuxtf5gHWVy5yk2XoLi7r+Q9Bb7KOrQn+IF0I4Yav1oqYhMGsZxg8ulu3QFHKjhG9pJT++lb4wxkoifAVg/sHfii6i0MMskurAnXWIDOkBa/4QakL4GhdhTvrQLGbG92nVB7ENSXKFURM27ax2hdNQutHzqC0bLx8jzawVRmjoFayUzUJWnfy60jjk2XtoCyUnMd1fdrSyU+g5MyeL+zsR0AkCJLEclTg5lU0S2fcBmNaueXh5ZefQsOQMFbk45y8NWMimA3MUh38UvzTsU04WExVT9IArP/dYguqYMjtVvSVq0hldYFxS/JjM/dpzdQaiIg3RvdkRjPqNXLVyFVytYYWChN7A08bTptqmGFWUTFZdcv0SITqFdFGxjRoD/CqKMRPHzuETjworPJnjG+IKfB4eQwnzD4DMthNqZbf4GcBFvU3ntLgbSiZtG6XCEyWYHZ1oj/08cYZdzsctT/uH3+DvPFxjIvXdfPDWd041ByNXxecRtHlPe0LhRi1ZWCZyxIpWK0TcVXOixlnV77VITQjIzuiMw8w4wzA7xRCVRvTcjyAa+WeLsTSkO60tammXk=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1ec507-2429-481d-c511-08db47aa9e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 05:37:13.3790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1ojzcxu471RFHVCZYRdDpj410qWahTjJQkedfLpdNT02WlKiP7FN8g0lNNufZ70J9FhXdEjcTdUA/lrJpyW8c/DvzJtAa/9AyLQwgiHgYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7865
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, April 28, 2023 12:53 AM Bob Pearson wrote:
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

Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>

The change looks good.
I tried stress test using perftest with multiple-QP settings,
and there were no error nor performance penalty. Additionally,
no new error was observed with concurrent executions of=20
the rdma-core testcases.

BTW, I think we should swap the names of "do_task()" and "__do_task()".
They look against the naming convention. Generally, a leading double
underscore implies that the function is used internally, so other readers
would expect "do_task()"wraps "__do_task()".

Thanks,
Daisuke


> ---
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
>  drivers/infiniband/sw/rxe/rxe.c      |  9 ++-
>  drivers/infiniband/sw/rxe/rxe_task.c | 84 ++++++++++++++++++----------
>  drivers/infiniband/sw/rxe/rxe_task.h |  6 +-
>  3 files changed, 67 insertions(+), 32 deletions(-)
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
> index fea9a517c8d9..b9815c27cad7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -6,8 +6,25 @@
>=20
>  #include "rxe.h"
>=20
> +static struct workqueue_struct *rxe_wq;
> +
> +int rxe_alloc_wq(void)
> +{
> +	rxe_wq =3D alloc_workqueue("rxe_wq", WQ_CPU_INTENSIVE | WQ_UNBOUND,
> +				 WQ_MAX_ACTIVE);
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
> @@ -21,7 +38,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>  {
>  	WARN_ON(rxe_read(task->qp) <=3D 0);
>=20
> -	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
> +	if (work_pending(&task->work))
>  		return false;
>=20
>  	if (task->state =3D=3D TASK_STATE_IDLE) {
> @@ -38,7 +55,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>  }
>=20
>  /* check if task is idle or drained and not currently
> - * scheduled in the tasklet queue. This routine is
> + * scheduled in the work queue. This routine is
>   * called by rxe_cleanup_task or rxe_disable_task to
>   * see if the queue is empty.
>   * Context: caller should hold task->lock.
> @@ -46,7 +63,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>   */
>  static bool __is_done(struct rxe_task *task)
>  {
> -	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
> +	if (work_pending(&task->work))
>  		return false;
>=20
>  	if (task->state =3D=3D TASK_STATE_IDLE ||
> @@ -77,23 +94,23 @@ static bool is_done(struct rxe_task *task)
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
> @@ -122,8 +139,8 @@ static void do_task(struct tasklet_struct *t)
>  			} else {
>  				/* This can happen if the client
>  				 * can add work faster than the
> -				 * tasklet can finish it.
> -				 * Reschedule the tasklet and exit
> +				 * work queue can finish it.
> +				 * Reschedule the task and exit
>  				 * the loop to give up the cpu
>  				 */
>  				task->state =3D TASK_STATE_IDLE;
> @@ -131,9 +148,9 @@ static void do_task(struct tasklet_struct *t)
>  			}
>  			break;
>=20
> -		/* someone tried to run the task since the last time we called
> -		 * func, so we will call one more time regardless of the
> -		 * return value
> +		/* someone tried to run the task since the last time we
> +		 * called func, so we will call one more time regardless
> +		 * of the return value
>  		 */
>  		case TASK_STATE_ARMED:
>  			task->state =3D TASK_STATE_BUSY;
> @@ -149,13 +166,16 @@ static void do_task(struct tasklet_struct *t)
>=20
>  		default:
>  			WARN_ON(1);
> -			rxe_info_qp(task->qp, "unexpected task state =3D %d", task->state);
> +			rxe_dbg_qp(task->qp, "unexpected task state =3D %d",
> +				   task->state);
>  		}
>=20
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
> @@ -169,6 +189,12 @@ static void do_task(struct tasklet_struct *t)
>  	rxe_put(task->qp);
>  }
>=20
> +/* wrapper around do_task to fix argument */
> +static void __do_task(struct work_struct *work)
> +{
> +	do_task(container_of(work, struct rxe_task, work));
> +}
> +
>  int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
>  		  int (*func)(struct rxe_qp *))
>  {
> @@ -176,11 +202,9 @@ int rxe_init_task(struct rxe_task *task, struct rxe_=
qp *qp,
>=20
>  	task->qp =3D qp;
>  	task->func =3D func;
> -
> -	tasklet_setup(&task->tasklet, do_task);
> -
>  	task->state =3D TASK_STATE_IDLE;
>  	spin_lock_init(&task->lock);
> +	INIT_WORK(&task->work, __do_task);
>=20
>  	return 0;
>  }
> @@ -213,8 +237,6 @@ void rxe_cleanup_task(struct rxe_task *task)
>  	while (!is_done(task))
>  		cond_resched();
>=20
> -	tasklet_kill(&task->tasklet);
> -
>  	spin_lock_irqsave(&task->lock, flags);
>  	task->state =3D TASK_STATE_INVALID;
>  	spin_unlock_irqrestore(&task->lock, flags);
> @@ -226,7 +248,7 @@ void rxe_cleanup_task(struct rxe_task *task)
>  void rxe_run_task(struct rxe_task *task)
>  {
>  	unsigned long flags;
> -	int run;
> +	bool run;
>=20
>  	WARN_ON(rxe_read(task->qp) <=3D 0);
>=20
> @@ -235,11 +257,11 @@ void rxe_run_task(struct rxe_task *task)
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
> @@ -250,7 +272,7 @@ void rxe_sched_task(struct rxe_task *task)
>=20
>  	spin_lock_irqsave(&task->lock, flags);
>  	if (__reserve_if_idle(task))
> -		tasklet_schedule(&task->tasklet);
> +		queue_work(rxe_wq, &task->work);
>  	spin_unlock_irqrestore(&task->lock, flags);
>  }
>=20
> @@ -277,7 +299,9 @@ void rxe_disable_task(struct rxe_task *task)
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
> @@ -291,7 +315,7 @@ void rxe_enable_task(struct rxe_task *task)
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
> base-commit: 209558abea74e37402fcc3d1217c6c1043d91335
> --
> 2.37.2

