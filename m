Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAD562ED01
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 06:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiKRFCZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 00:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKRFCY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 00:02:24 -0500
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37F95BD4E
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 21:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668747743; x=1700283743;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=oJ3Hmh7Ji0WHp3U/OmX4DK7IqImGW9LeraDJy3UWnxs=;
  b=CRwHEM/ec2+I2o2kWN4jPgLFoYM49wir4oj4ZL/NnjVM9uYvT/aSYe9c
   JakdmA7Py3CFxuxRRJa6kX9PvlQuSKGVweWfn0wzO6jlCirwmHX4gte+d
   bEm1K73pt0ZuN5DbWRhQxSakNUHQLNH/CQrRkLfp40R9OYlkJm5g4SDgC
   0CylBOhYAkis5cldl+K5xuzA3ifBa8qIZ853hWiGYnPlDSzHMOrFiM/5S
   p8AqdwEULBciQZ1sXIctjiSrOIPik6O9EYROGlMGEamoVfI+iSaGpzvQM
   bdxC1Q/giHaWjjYTJnapbe57fNCq89G6NEi3c7RFmsrvY9c/Hequ71nVE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="78559901"
X-IronPort-AV: E=Sophos;i="5.96,173,1665414000"; 
   d="scan'208";a="78559901"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 14:02:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nln8TFeIODIgUtYQ3a18KrO75xzWkIgWGjFgqxGfIcMh3EJRauvDYvU1IVO3c2jsneHjUKGf0uul32FMwux5Az4IQYnn9cG0TTE3vRsmbrR0iBbmFG6XegCEv9SOTyIS0HfXmWVaC5RVLgcflxN9//TSzSJxKzKvu2rWX/jau1gkoR95n1kLRBaRLtp3bpYLX+BGWDxk156ujA8wk1j7gZ/i5wJmGTcYr4au3gF0crPvgbIhSXNNEinoy8kugOwWpmhWCaJ9ibm7XzjQPvB0sRq5PSLDeWAOEEe+1GdUMSFhDqXwRj15oRZ2gODY3E6cz67V5AJZcH++u1xI31TrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFI1MgSEDFEqX57410cwAsRk7IAth8nWLBvjEl5EEIA=;
 b=hq62QH4ZALAgnpM5YDoBCgQmDICvLnIItERbMBcfGPKDURD75nMCnFapmP8f0GCdBgDDiKz2GnkXa4wR8z7YHsiaP424Ttrz9JAgiCTBaSuokmOYMcTkWLVew5ws7h7KxWYo/poA4z7mFc2ZIKxbuTxVdey98qq5QffQefIXCTTOYR3a0iKpX+gwDmV3q/EydAqKH+i3J43r+wDBRcRXYoRSw9C/XLf/VNX+hg4yaGGk2YcaOTpBguMfD5j09DXF/VBShWRYOEju1b4NGtYhKRgS3tQeQSolFMaTK3jh5WTB2yXCWlGqKfCltr6CyrGI9ZwGVixVj5OIYjcMQjaZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYWPR01MB9952.jpnprd01.prod.outlook.com (2603:1096:400:1d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 05:02:15 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::38e9:4e9d:6868:3dd3]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::38e9:4e9d:6868:3dd3%6]) with mapi id 15.20.5813.018; Fri, 18 Nov 2022
 05:02:15 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v3 00/13] Implement work queues for rdma_rxe
Thread-Topic: [PATCH for-next v3 00/13] Implement work queues for rdma_rxe
Thread-Index: AQHY60QPhEmsfEs6mEOBpNno2u2Vq65EOxKQ
Date:   Fri, 18 Nov 2022 05:02:15 +0000
Message-ID: <TYCPR01MB845522FD536170D75068DD41E5099@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
In-Reply-To: <20221029031009.64467-1-rpearsonhpe@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 8d75a03087a240a2accd57f007175145
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-11-18T05:02:12Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d605788c-3bec-47f2-8327-908fb7af6b64;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYWPR01MB9952:EE_
x-ms-office365-filtering-correlation-id: 27b8dfa4-6762-4ca5-ef1f-08dac9220fbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TXhM/CGQfJfDiuxP6yJd+ldsQHCHYRyry0dd/j0vsMB4jym0i0WGtjsdg0ptDTLrv7xRMxQLtph50xGZumv+CMMO5LO2FPlij5oOsngVttUeQsGzGpWOWoGZHc5+GmxQifCFUq6PLH1U5RutVowfGFc+RLVkSCfdvC7BDMf3/5xgrV/YXK9P8WlKvSoLb24GpqRjd3i6+Pwer4/Mr/E12cEymG78ywxxArkQ0SKKtPe8hAHsD5Ou43+hGqom/reNPDWchzQLr4DY8B0DCe1/8XzB4yGCVPQaDjPeeZFRX7brTMkInETkN3czIqM3R3yLnSnAmGXYU9mmC6EDNi+Z6VZATQ6EubSo0P4BphMpwiLcRVshnDaAjaxqMLWB/ldPzrFA2SVyvCkq1QzA8fgYwUU0QRsFiK9h+dWRap8VmQdp1257RVKoo8UNy9lOZcTygvqefElBNoEEOusPoXdBmJBUqxeZhppD4kBIJ27Kz16TpQ9MoORFPKxExKvs3XSUuHCZVdOvgAXKAne2/KcWRliXC7nVmkGg2+Z1JhRHAFbnimKsD1YwYDImhLIA5D2nMequkeAN7wQDe/D7c8fe1q2+qiv+WWS1JVd628hbrvHtfJb/NSvin8G2/lGqfWVVogGDKKkEmbtnDfn7QE2OmrDRvlgVlBK8lBGyvoQqHvJbjyt3ObU6Pq8Dd5gyO61tjXCaS7XcXZz7DUiqDmQxWIY24cR3HQEsl1JddAR+2bs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(1590799012)(83380400001)(2906002)(85182001)(186003)(52536014)(8936002)(41300700001)(38070700005)(33656002)(86362001)(55016003)(5660300002)(122000001)(38100700002)(82960400001)(71200400001)(110136005)(53546011)(7696005)(6506007)(316002)(45080400002)(9686003)(76116006)(26005)(66946007)(66556008)(66476007)(64756008)(66446008)(8676002)(1580799009)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TnFyaFlGYUFWcEo2VDhIZU5GeVZSOG1KcUhwTTB4MHBsVHl2ZUJSaVZs?=
 =?iso-2022-jp?B?NExUSytkeFVsd0VsR3ZaS3dXTysvMnlzQWdHOFo5ZVpQYmU0U2JKT0Zw?=
 =?iso-2022-jp?B?M0dtellWV3Fuc3hpMXJlV1VKbkJlai9EalNrNCtFUUlwOHlBUjJNNTNw?=
 =?iso-2022-jp?B?YTRHdGt0Vk02Ylc2ekcvbVdJb1p5eG8zZ1J4YjZrbGlqS3hJQlNKSWlI?=
 =?iso-2022-jp?B?L2Q2NXZWSzRLaENGQkdmNXh0cXNwSVJPa2ZYV1owYktsK3dRK3JUTGRn?=
 =?iso-2022-jp?B?NXVlREdvVHova3VYeVlDQWgrSUFrWkk2dk0wdjY3RUZCVnVQT002TE51?=
 =?iso-2022-jp?B?SUwzNGZJSC9tcGxPUXh6K0krRFJoYU5Pc0IxbWNGaEtOSkFNOFFGaGhq?=
 =?iso-2022-jp?B?L1NuV2tOZTRiQks3LzFMUWNYTGgxVnlsMlNvK2I3a2U0Y0VNRWp4dlhK?=
 =?iso-2022-jp?B?QWo4VHM4eDRDMEZXbXhLdm9zUXdWaDBkMVp2b1ZTbnhVdDBJbHJsY0tL?=
 =?iso-2022-jp?B?bTNZMCtNU0diWVFVd0ltU2JwQnZBTDk5STFoTmRLQm9qa05nenlOV3RE?=
 =?iso-2022-jp?B?NG1OTDhpTTJzWWxnRGRqNDhnZjlOdm9QQUtwb2hqd3RsQXFvZEhXbDl6?=
 =?iso-2022-jp?B?YjNtbC9FVmNJckZEUkFKMUh3WTF6T05IK09DNURaK0JGamoxczBPUHFW?=
 =?iso-2022-jp?B?MUFNMmF5WFVqVi9qTG9WazB0bFlVM3pEeW9Ram02VFRDd1ljbTBNUHB6?=
 =?iso-2022-jp?B?dlRiRHd6a3RjN0NyV0d6aU41cGZxUFBkRG4za1lYcThFVm9OZ1NRWWQ2?=
 =?iso-2022-jp?B?a0Z2Q2pGY3pURVpvZ2QreW1abzhwOWdQQUxPVUcrSENLYXMyaGh1c3dP?=
 =?iso-2022-jp?B?MWhNTU54Q0JKTXdEVVVGckR4OHVsVGl6UDNkbm84S1hZaU1Eam4zNlJq?=
 =?iso-2022-jp?B?TWowVDJ5c0grUUpaNTJoTnk1Mkx0UkYrREZhUUpmbk5GNlo5N2RWSnhB?=
 =?iso-2022-jp?B?b3FscFhNakRpaWQzMFdzZU1qZy9ieUkzZTE3NlhpeUpBVUVGK3pvYm1o?=
 =?iso-2022-jp?B?cFNHRzBwV3V0QnR4MjFiSmtLQXBySnBBMWwwUGl2dTBVMVovNkNmQSsy?=
 =?iso-2022-jp?B?UnYyV2M0ZXo1clFGVnNZZjhodm1YalhXTWRxZDVZK2tCUmdlQXlZS3dq?=
 =?iso-2022-jp?B?UGZEdTljRVdkOTBDUGRZQmJGMWc0MmRHcXVob2MwL0RtNDB5MkVrQ1Ra?=
 =?iso-2022-jp?B?djFWdnF3M0dwcDNzNUFvRndmN3o1bjZwU3d5bmNuOFlhYXFNUDNNM0E2?=
 =?iso-2022-jp?B?bFh0dkVKS2xsaUIvbFNOblhRc2dieUV1TnpyZEZzOEJjZU1DZUZIZ3hJ?=
 =?iso-2022-jp?B?U21xc1RrcElMQ3o5TDdEYVU0SmRiTkpMRzZyOCtPczNmdTI0Zi9MdXVz?=
 =?iso-2022-jp?B?Zk9Hc3F4QTlramRtbUJrVWQrOUc1eFVPckh4T0hERDBaMEczeHAyUHJy?=
 =?iso-2022-jp?B?VEFHdDNNR3N4L0xyTTV3eTVqYW9zeXZTNk9rRGsvMzB6MThBMmV1Tk9o?=
 =?iso-2022-jp?B?bTFWT0tmeG1oUCtiSyt0QjdWUUN3Mk81eHgxRlNrWjBxUVhWZzFPRHZQ?=
 =?iso-2022-jp?B?b1J6OFRYOUNiTktQaDFGcU1QaWxKTGhsRWlDUGNMNTFnRWhUajJyd0VM?=
 =?iso-2022-jp?B?Q3B2aHNtM1JiVGtGbmQwbnp1NWQ2ZlF0VzdpMThFR2lmbW1XWGN5Vk5W?=
 =?iso-2022-jp?B?MGdrRWVHM3BPRk92SGxJb3F3VmlIeFVoeW5NM1pTVlhYc1dpMEJzTzZs?=
 =?iso-2022-jp?B?WUdDMGErK0dnVlk3ZnlpZUEvaGl0Zzd4TS94V2tEUE02ankvdWdRVklE?=
 =?iso-2022-jp?B?THRna29XNWtQRVNnRVJQNmlJcVkvTGRIL0tKU1NaeGcyRFJ5ODNjMWhI?=
 =?iso-2022-jp?B?bFpKUmFGdWo1Unkwa0lYODlLRnptNTR1eEFMdXlYaDIvK3FEekZBY0pU?=
 =?iso-2022-jp?B?b1FCamlKdG1iRysvL0QxSXlNa2RhcElPVkZZL3RXUTZlQzNxS0t0c3A0?=
 =?iso-2022-jp?B?aU1XdUVQUTJ3TS81L2hwMmQrL1FkMjhIZDBXd2N0QTdXUVlCZnhsQUhP?=
 =?iso-2022-jp?B?UitsaFpzTzJHeW1BWVJvNHZveGtiRTA0N0JDTzlTOFFRMWFIeXFlSEZQ?=
 =?iso-2022-jp?B?U3NvcjNlNU1NbGJ4MURYU2hxNHloNGF5RThHNE5tMitrVDkxRWlQRk9a?=
 =?iso-2022-jp?B?aGlOU3BoOFNSWU1wUDJHQmxpSGpqb1F1UFcxckl3L2FWOU5kc3RXb1JI?=
 =?iso-2022-jp?B?dkZ0K3JGR1M2TVFFMTZLMVZqTHpJcXAxWmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WgFl+sTH5202Df0QHR+Vkj7AzzvJPVukGn9Tgdf9SbV2rKwiOzA5gdRFGJtaQJvNQeQxkHasULoeHX9I9e22WLrFDDlFwOfc1FSHy3BV/j1fQbJ8GyrMvoP+6xeRMGIcHJ2pjDXXthUEcMqnC/Mi6V+UtReKW0AXwIHkqkglJfb3qBz/qNKDTOhNwLBa1AS/d5hv8RKgLepIozeV1nByKlgTGMz6wIIEqK0xgcrLnCnyCPM2VPet3k072ljTNugiBz7nhaaBExEh8WMqwkwK97vOs5/MjLK1tDqawj9VO+qMqybLm+cqENRkadaNweyAVqgdb6kKQ5zmlpoE0Z5c2736HjuOEWhgKKkUs7JTcU84ufKjJhO455EolDH0UNI3srKpXlAXkI09PKKkBYuOR//o7Ewm/4UkEtUBLEjJ/78yN3FH2J5kip+Ypmco9F3Llqjz/Oe9sKrVZr3dS0BBSj+uX3ch3t+dR3CVY+u9EPxpGGVTW5d8UeCOhE9thlO4ClggWh6mRiYUgkE6OSHxvGfENjVvyRtCqzoSVgqq5Yq21yqWfmhURAtDZBMch0ERtQHsghwBG8wCoS8PEx89l2CQ5ex+8POoCnEL5NxquhMyEial6tdC4Ce5Yx+IHp2eNpIPwV17jQWhDaTCTmlKIAqzKn+TjyRcxDUOIiX2ZcDxqj1k6Xx2g40SCQO6gCpqznUe8otxW30oiTYf1iPj6WLn7eLHDCpI8YhHkIBaLcdLv94s+i+C29uD+mmaEft/t5/K5DM49+jagq0zrtV4ifNTJ5IPjzOoBMGs9IAXVzeHGST7yB1OG/sUOczQpdHTdLMzuKhjNeHUoRSm8a+gxJ56MhC3eRuM89HQuE8kCevdiSasRtxm4kRi4cfPzVik6V4nEINn+WAa7rxNTPweJg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b8dfa4-6762-4ca5-ef1f-08dac9220fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 05:02:15.6301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUPG2wxGWpFrd1fSTGxfZLjkeUP2tAon/Fh27QX9eLFN8ewgjDjNgCdwefekmAYezJoEjvDcv81bqeuarG2dxjRkdC3RrvMFxXY9PCMd81M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9952
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 29, 2022 12:10 PM Bob Pearson wrote:

<...>

> Bob Pearson (13):
>   RDMA/rxe: Make task interface pluggable
>   RDMA/rxe: Split rxe_drain_resp_pkts()
>   RDMA/rxe: Simplify reset state handling in rxe_resp.c
>   RDMA/rxe: Handle qp error in rxe_resp.c
>   RDMA/rxe: Cleanup comp tasks in rxe_qp.c
>   RDMA/rxe: Remove __rxe_do_task()
>   RDMA/rxe: Make tasks schedule each other
>   RDMA/rxe: Implement disable/enable_task()
>   RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
>   RDMA/rxe: Replace task->destroyed by task state INVALID.
>   RDMA/rxe: Add workqueue support for tasks
>   RDMA/rxe: Make WORKQUEUE default for RC tasks
>   RDMA/rxe: Remove tasklets from rxe_task.c

Hello Bob,

I have found a soft lockup issue reproducible with rdma-core testcases.
It does not happen on the latest for-next tree but with this patch series,
so we need to fix the issue before getting it merged.

I did the test on a VM with 8 CPUs. I fetched the latest rdma-core and buil=
t it,
and executed the following command inside 'rdma-core' directory:
# while true; do ./build/bin/run_tests.py -v --dev rxe_ens6 --gid 1; sleep =
2; done
(Please specify your 'dev' and 'gid' appropriately.)

Before 10 minutes passed, my console freezed and became unresponsive,
showing the test progress below:
=3D=3D=3D=3D=3D
test_create_ah (tests.test_addr.AHTest)
Test ibv_create_ah. ... ok
test_create_ah_roce (tests.test_addr.AHTest)
Verify that AH can't be created without GRH in RoCE ... ok
test_destroy_ah (tests.test_addr.AHTest)
Test ibv_destroy_ah. ... ok
test_atomic_cmp_and_swap (tests.test_atomic.AtomicTest) ... ok
test_atomic_fetch_and_add (tests.test_atomic.AtomicTest) ... ok
test_atomic_invalid_lkey (tests.test_atomic.AtomicTest) ...
=3D=3D=3D=3D=3D
Note this does not always happen. You may have to wait for some minutes.

Here is the backtrace:
=3D=3D=3D=3D=3D
[ 1212.135650] watchdog: BUG: soft lockup - CPU#3 stuck for 1017s! [python3=
:3428]
[ 1212.138144] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_res=
olver nfs lockd grace fscache netfs rpcrdma rdma_ucm ib_srpt ib_isert iscsi=
_target_mod target_core_mod ib_iser libiscsi scsi_transport_iscsi rdma_cm i=
w_cm ib_cm rdma_rxe ib_uverbs ip6_udp_tunnel udp_tunnel ib_core rfkill sunr=
pc intel_rapl_msr intel_rapl_common kvm_intel kvm irqbypass joydev nd_pmem =
virtio_balloon dax_pmem nd_btt i2c_piix4 pcspkr drm xfs libcrc32c sd_mod t1=
0_pi sr_mod crc64_rocksoft_generic cdrom crc64_rocksoft crc64 sg nd_e820 at=
a_generic libnvdimm crct10dif_pclmul crc32_pclmul crc32c_intel ata_piix vir=
tio_net libata ghash_clmulni_intel e1000 net_failover sha512_ssse3 failover=
 virtio_console serio_raw dm_mirror dm_region_hash dm_log dm_mod fuse
[ 1212.147152] CPU: 3 PID: 3428 Comm: python3 Kdump: loaded Tainted: G     =
        L     6.1.0-rc1+ #29
[ 1212.148425] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.13.0-1ubuntu1.1 04/01/2014
[ 1212.149754] RIP: 0010:__local_bh_enable_ip+0x26/0x70
[ 1212.150464] Code: 00 00 66 90 0f 1f 44 00 00 65 8b 05 c4 7e d2 4e a9 00 =
00 0f 00 75 31 83 ee 01 f7 de 65 01 35 b1 7e d2 4e 65 8b 05 aa 7e d2 4e <a9=
> 00 ff ff 00 74 1b 65 ff 0d 9c 7e d2 4e 65 8b 05 95 7e d2 4e 85
[ 1212.153081] RSP: 0018:ffffaf0b8054baf8 EFLAGS: 00000203
[ 1212.153822] RAX: 0000000000000001 RBX: ffff8d2189171450 RCX: 00000000fff=
fffff
[ 1212.154823] RDX: 0000000000000001 RSI: 00000000fffffe00 RDI: ffffffffc0b=
51baa
[ 1212.155826] RBP: ffff8d2189171474 R08: 0000011a38ad4004 R09: 00000000000=
00101
[ 1212.156862] R10: ffffffffb2c06100 R11: 0000000000000000 R12: 00000000000=
00000
[ 1212.157860] R13: ffff8d218df5eda0 R14: ffff8d2181058328 R15: 00000000000=
00000
[ 1212.158858] FS:  00007f8cec55f740(0000) GS:ffff8d23b5cc0000(0000) knlGS:=
0000000000000000
[ 1212.159989] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1212.160837] CR2: 00007f8ceaa15024 CR3: 0000000108c2c002 CR4: 00000000000=
60ee0
[ 1212.161841] Call Trace:
[ 1212.162205]  <TASK>
[ 1212.162522]  work_cleanup+0x3a/0x40 [rdma_rxe]
[ 1212.163172]  rxe_qp_do_cleanup+0x54/0x1e0 [rdma_rxe]
[ 1212.163888]  execute_in_process_context+0x23/0x70
[ 1212.164575]  __rxe_cleanup+0xc6/0x170 [rdma_rxe]
[ 1212.165245]  rxe_destroy_qp+0x28/0x40 [rdma_rxe]
[ 1212.165909]  ib_destroy_qp_user+0x90/0x1b0 [ib_core]
[ 1212.166646]  uverbs_free_qp+0x35/0x90 [ib_uverbs]
[ 1212.167333]  destroy_hw_idr_uobject+0x1e/0x50 [ib_uverbs]
[ 1212.168103]  uverbs_destroy_uobject+0x37/0x1c0 [ib_uverbs]
[ 1212.168899]  uobj_destroy+0x3c/0x80 [ib_uverbs]
[ 1212.169532]  ib_uverbs_run_method+0x203/0x320 [ib_uverbs]
[ 1212.170412]  ? uverbs_free_qp+0x90/0x90 [ib_uverbs]
[ 1212.171151]  ib_uverbs_cmd_verbs+0x172/0x220 [ib_uverbs]
[ 1212.171912]  ? free_unref_page_commit+0x7e/0x170
[ 1212.172583]  ? xa_destroy+0x82/0x110
[ 1212.173104]  ? kvfree_call_rcu+0x27d/0x310
[ 1212.173692]  ? ioctl_has_perm.constprop.0.isra.0+0xbd/0x120
[ 1212.174481]  ib_uverbs_ioctl+0xa4/0x110 [ib_uverbs]
[ 1212.175182]  __x64_sys_ioctl+0x8a/0xc0
[ 1212.175725]  do_syscall_64+0x3b/0x90
[ 1212.176243]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 1212.176973] RIP: 0033:0x7f8cebe3ec6b
[ 1212.177489] Code: 73 01 c3 48 8b 0d b5 b1 1b 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 10 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 85 b1 1b 00 f7 d8 64 89 01 48
[ 1212.180072] RSP: 002b:00007ffee64927a8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000010
[ 1212.181150] RAX: ffffffffffffffda RBX: 00007ffee64928d8 RCX: 00007f8cebe=
3ec6b
[ 1212.182131] RDX: 00007ffee64928c0 RSI: 00000000c0181b01 RDI: 00000000000=
00003
[ 1212.183099] RBP: 00007ffee64928a0 R08: 000056424f8c0c70 R09: 00000000000=
2ae30
[ 1212.184064] R10: 00007f8cead75e10 R11: 0000000000000246 R12: 00007ffee64=
9287c
[ 1212.185061] R13: 0000000000000022 R14: 000056424f8c0560 R15: 00007f8cebb=
903d0
[ 1212.186031]  </TASK>

Message from syslogd@c9ibremote at Nov 17 17:03:12 ...
 kernel:watchdog: BUG: soft lockup - CPU#3 stuck for 1017s! [python3:3428]
=3D=3D=3D=3D=3D
It seems that ibv_destroy_qp(3) was issued from userspace, right?
I am not very familiar with uverbs ;(

The process got stuck at the do-while loop below:
=3D=3D=3D=3D=3D
rxe_task.c
---
/* busy wait until any previous tasks are done */
static void cleanup_task(struct rxe_task *task)
{
        bool busy;

        do {
                spin_lock_bh(&task->lock);
                busy =3D (task->state =3D=3D TASK_STATE_BUSY ||
                        task->state =3D=3D TASK_STATE_ARMED);
                if (!busy)
                        task->state =3D TASK_STATE_INVALID;
                spin_unlock_bh(&task->lock);
        } while (busy);
}
=3D=3D=3D=3D=3D
Typically task->state is 0 (i.e. "TASK_STATE_IDLE") when we reach here,
but in the infinite loop, task->state was constantly 1 (i.e. "TASK_STATE_BU=
SY").

IMO, the bottom halves completed their works leaving task->state "TASK_STAT=
E_BUSY",
and ibv_destroy_qp(3) issued from userspace thereafter got stuck,
but I am not sure how this counter-intuitive state transition occurs.

Do you have any idea why this happens and how to fix this?
I cannot take enough time to inspect this issue further right now,
but I would update you if I find anything helpful to fix this.

Thanks,
Daisuke

>=20
>  drivers/infiniband/sw/rxe/rxe.c      |   9 +-
>  drivers/infiniband/sw/rxe/rxe_comp.c |  24 ++-
>  drivers/infiniband/sw/rxe/rxe_qp.c   |  80 ++++-----
>  drivers/infiniband/sw/rxe/rxe_req.c  |   4 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c |  70 +++++---
>  drivers/infiniband/sw/rxe/rxe_task.c | 258 +++++++++++++++++++--------
>  drivers/infiniband/sw/rxe/rxe_task.h |  56 +++---
>  7 files changed, 329 insertions(+), 172 deletions(-)
>=20
>=20
> base-commit: 692373d186205dfb1b56f35f22702412d94d9420
> --
> 2.34.1

