Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D0A2BC60C
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Nov 2020 15:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgKVOad (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Nov 2020 09:30:33 -0500
Received: from mail-bn8nam12on2090.outbound.protection.outlook.com ([40.107.237.90]:32608
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727634AbgKVOac (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Nov 2020 09:30:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7JOzv4fwtiwHhcj4LfgIYW1iSpB3lstNKH3uPiqafU7XsZzV3JcqvIoq74Hk6/C90tswXmCv1mQ5Y3BHzlxGw2UklbJ1+YC8ePJnrNd9EvQLfbAiKDYRUUtutTVRss95hWP+17/Mp2PvjKaXpBMgmCiq1RMK9C5Ev/JuH+L1Ls5wgLvqzClaizvOvSF2EnhShJncxxzXJq/srn42MzIkoZSKR+RocrpoXWEUereHafed/TbIkaVq79CS78UTC29ETBenDleIUA4yBdxNHiQeolS8R+f7OQyDd5RehVyy6FzCp68nKYQB7+iMdUTxwLrCq5nW+Is8tWG6UyTnEkgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UpxKAc1BgRlCloW1fVl5yxEIpbky9uS56DVS5mXZWs=;
 b=PLFvCad0r+aq+aKylRVx7d9bWAVYyg4UTO3dt3fgB2OolJ3cP/LUZKMhrfNKw36cnACRenBamGSt8mpYxfTicJMwYJqnZJ/upRzQmikeus2Llou416fUzUiiGrZJ1q46ATcvYyMN5Zn11pZPi7AkJTKtTwqpBN3kZbqxFjOZZtoNIHMvCeu7NvsQNmG8oEFef7uyVdEPBY3gLt3JH+IjVyC29FoksCzWP3F2UAIDI/03YRS0Ka4VRly4FKxLDwu/BZU6ELyoC94AFEtda6tvJvreoLuPtpfsm84WHVj5NIw5Itbfh3yfcmrjCWxSHa8HMMPurM7UFIV7TNf1oDOvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CornelisNetworks.onmicrosoft.com;
 s=selector1-CornelisNetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UpxKAc1BgRlCloW1fVl5yxEIpbky9uS56DVS5mXZWs=;
 b=V2onDL8uvXYye1R6DXRi3pYxzLD1u4lBnV053+eUbotI67GXOIS5uxB2AZd6CCegpUa0tTh+4Z71E5EzFaDAOSxWvsC+PBUWRGceSVhdGE+HdmK+tbLwe+632S/txq9IX1wSehY+W24VR7KGFS42cbflHCowMuY9xRxbfW+dICJyatR04STT7X7NssBq4UE4NTQws6hyddnbPgIzkSs4H5WCCGBdtgL9/8icHmIS8rT339fT1k0UJDd7Saf0vieBPF5MtmaJogZLeVfqX3WqJUvWqyluzAKx/puvziQK9xL4CKz0iXNwCu32JUNYYgx9uDKgBnCxBIRQCses107UEw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from BYAPR01MB3816.prod.exchangelabs.com (2603:10b6:a02:88::20) by
 BY5PR01MB5876.prod.exchangelabs.com (2603:10b6:a03:1ce::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Sun, 22 Nov 2020 14:30:30 +0000
Received: from BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::c436:2a2e:75d9:ebc6]) by BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::c436:2a2e:75d9:ebc6%5]) with mapi id 15.20.3589.025; Sun, 22 Nov 2020
 14:30:30 +0000
Subject: Re: [PATCH 008/141] IB/hfi1: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <13cc2fe2cf8a71a778dbb3d996b07f5e5d04fd40.1605896059.git.gustavoars@kernel.org>
From:   Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Message-ID: <e9d82266-fcef-336e-df61-22d80491d91f@cornelisnetworks.com>
Date:   Sun, 22 Nov 2020 09:30:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <13cc2fe2cf8a71a778dbb3d996b07f5e5d04fd40.1605896059.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [134.134.137.73]
X-ClientProxiedBy: SJ0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:a03:333::28) To BYAPR01MB3816.prod.exchangelabs.com
 (2603:10b6:a02:88::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [134.134.137.73] (134.134.137.73) by SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Sun, 22 Nov 2020 14:30:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1da0d059-8a91-41af-9912-08d88ef3296a
X-MS-TrafficTypeDiagnostic: BY5PR01MB5876:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR01MB58768E9AED8197583D09DA56F2FD0@BY5PR01MB5876.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rt6tI/tuj1wm4TTeqwAtCvql2I4HPShatT3kq1u9kL8XMNKy0QAY/LIaEvdSCZD3xhhnWaCeDkiyNuua0Wf2zqOFAiGxBg1HoD8wMqvcu8qqc6wJXov6VwvS18rIQwigA+Qz8QUFQgUWtqErFNlOUGw8+SRVZ36hZ2v01HME0TdRUjfLhXduJFMp5ceAZCuNsG0T5C3081nQcLG/aJD1hJQ526Ra+P4U6y3CLUD50m/tBvCA1jEE0ymtoEbNJ0TyMx6y9qh42JoC/dM26qsL96RoczYMXdRE2CibzJ8mV1nr6dIbMmvwdKOTrisxTekZxb9u7FlTlelD4Pn+F6/8OWgEGm14RyCoAIWXupaaFfzwfeMTLh1QbbWYB7NLlK9auAPrCZklvCzgW14VBl/6tbg0AfEfJ+x5ztx+iHevy9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3816.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39830400003)(136003)(376002)(346002)(83380400001)(8676002)(2906002)(5660300002)(16526019)(110136005)(53546011)(478600001)(4744005)(4326008)(86362001)(8936002)(6666004)(36756003)(316002)(186003)(26005)(16576012)(31696002)(44832011)(2616005)(956004)(52116002)(66556008)(66476007)(66946007)(6486002)(6706004)(31686004)(3940600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3NHzetFtpNWh6W1LchVWRkXIiuVZV12hCCAJGYHszcCzxxHyNLW19PjW3ZGCiBQPNN2GIPsj0Ch/RP0juGSbEHnGaxs5zj8+Hi6CcZo03rynAwtkEZp0/frEeqmLRp2P/YyB/KoPa3aiaw1Vxz/FUJ0iS6ql+AeIbor9D5ifKHkNifOWx4D9HtrfBfBDKp+8my0+oHke+UkKrco0h+uZ2lUE4e6LVWwr93xJByxti1Q5odbBHbnePSswBowwO+rK+N68bCE8Fyx7Vrc6XvvY04KYQGAMc5f1nlTqPuwX0Ds5DjEXxMB7/vOTQnS/q20heUafr2B5XGlFlPB4GaSkbyplMH51TtmUMxPldmcvw1c2XaGYYDP44FIhVk6wnICPQj7fMvMl+BJqghEMqJmcljvc4FpOYJl++TT7CJLuFlWmX6NGAu337DN1BJW0Y3H4ry6JYJQfw+N6EVaeVkgsgjvXgiewkVKrIIk3YeDV2IsF8IGdzAPFOx/k+wQiPe2p7SxlqTvP1uCsrSsh5t+ykJxA0B9PrDNpV6GkvSyPadpbjFOJVvWIwQrRzobkFG8OpgYm6wgjAy3u8QgdxOgu+Q4ibs9q086l5RQMKcoUQSthwUnSMYgodW+UyLSW029YQkCaH/iHlUZQhqq1GPmCzg==
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da0d059-8a91-41af-9912-08d88ef3296a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3816.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2020 14:30:29.7933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wr9H96q/2MVFI6v8pzWzkoSKMF0ZD873AEBPFjppFNyBsb3LgTUH2h37b5K1PpSluY7LfGZEmTk6NIft6tUH+wmBm1yDL+4GqkF1X0vWiDvueXCh8wgBQ8TYuNGs5cDD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5876
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 11/20/2020 1:25 PM, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead of just
> letting the code fall through to the next case.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good and tested with TID rdma to cover the interlock case.

Mike

Tested-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

