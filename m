Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E0B52E411
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 06:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbiETEw3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 00:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345428AbiETEwX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 00:52:23 -0400
X-Greylist: delayed 1096 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 May 2022 21:52:16 PDT
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02hn2233.outbound.protection.partner.outlook.cn [139.219.17.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0373D66FA1;
        Thu, 19 May 2022 21:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTgGc0h/0At8MBttzBkK8Ng18cD+wAmbmz35rRkzX2XuiAckWJA0l1KXg8aLkYfgPi7sDokHr+gmzTfIOQwiuhqYCylSHEqPt4cwrvgFr0m85bRiUMvUETEKTlm2tUySZxPlti+0GU9By9/3mxtOUO/cUjSSKmn595kW29RMwYjYtkiypQRgPmuVxyfcb9fdrJBYHRPYr8r98y/a+ZOGc7Cz05b0xj0XOGRFR/5K2M2Cwk6d50WHTQe/WWhbyj2nzaSrEa3wSi8zTbAhTmFZgTNxODWIAMQF2tutBJ8+w3lTD0TPpI8pR1KexM3pWkefgXNuSL/aAK10aamR2eAVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=jIaZzQhQA82X+a0w7q6rEhMwvvJys6dL9lzHi1YcEHPXS0ShHMMxGO/E4kwE5RFdGDsxNV/sDXzSRe5V7FiQcHL7Ts3xOoARSBxYkYqqvuNArc6vqgtGlFu+AzSbLh8oMxVQ9FPDfsbHSlaWFqdvxPZX/f2splna30cRSGNYvSwZ4FzRM49vG68NhNSeZxr5lh/6ufXPq8Z5seuvKGxNF+4vTk6EHcPf3VXZLySJiwb6dS6lBwDOhGTkERmYJy+B1dkjzVFh2cEISar82BftErG47D2dGJELAvGzNLcV/KfE5uLQShbBvdXYkyqL2DULEUdgNIrISQpbX7mJZzo/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gientech.com; dmarc=pass action=none header.from=gientech.com;
 dkim=pass header.d=gientech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gientech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHa7Vpxtm/u3S4otqoZTmpXUuVJNGmaT4A6UJUMDuKo=;
 b=foLc+ZHUrkiTBblRVDfCc5ao8/S+6hbc/DEoLKcVaPpPajKnX4z7jSqL3SVfuMywUWqjNX+MXQpx8lfrn58abX8BQ7LyfzpBFg7lGTgSn3OWVF6ByZHmCqQIQruFX9tY6ITLzTeCdVYTr3g07IyxdRCBQpaevPHM0jyKGIrqu23jo48JVXDsd/H8mBYChEC31FE1W17JIWlGPi7Yn9hvE5K4PslZrcVIsfkoq8jh5tyLdDvbf3AlnqATiYXQwFGngzOSFF+k3dXhjkcz2T09rHYyBYW90HKJldrCOPFwxUy0umrG6snFvwq5WbkBpNfCmPYPNQe80G+qndcTRfokPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gientech.com;
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn (10.43.110.19) by
 SHXPR01MB0575.CHNPR01.prod.partner.outlook.cn (10.43.109.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.15; Fri, 20 May 2022 04:19:12 +0000
Received: from SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19])
 by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn ([10.43.110.19]) with mapi
 id 15.20.5273.017; Fri, 20 May 2022 04:19:12 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ree
To:     Recipients <cuidong.liu@gientech.com>
From:   "J Wu" <cuidong.liu@gientech.com>
Date:   Wed, 18 May 2022 21:19:15 +0000
Reply-To: contact@jimmywu.online
X-ClientProxiedBy: BJSPR01CA0002.CHNPR01.prod.partner.outlook.cn
 (10.43.34.142) To SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (10.43.110.19)
Message-ID: <SHXPR01MB06238D40DEF6AAD61B0227D389D19@SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41ca1767-fbf2-4795-4231-08da39141d61
X-MS-TrafficTypeDiagnostic: SHXPR01MB0575:EE_
X-Microsoft-Antispam-PRVS: <SHXPR01MB05757B59B2D012F5EB1E390D89D39@SHXPR01MB0575.CHNPR01.prod.partner.outlook.cn>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?2HAd0fwgQDXkUZsGOEW4k34pXdmeGj4x7s+V0ucJJ4+0gri2WmjmZnuBM0?=
 =?iso-8859-1?Q?vwoY9h8ruvMfbVR52dwMpwwjF3PjR7nWXSXKTJLbveOT/OOiyP2rOkOTVf?=
 =?iso-8859-1?Q?/PsCHnU7yKCeKnLH2iLW5+7FxP6daDPy34OXIZ3/GIFtlNsB5aAFX0mp5k?=
 =?iso-8859-1?Q?97q76D9I63IVoNUqzQ7cyar+J7q5Gz6MZhEV4qf7vBq98Ywv8wsUnf5M+b?=
 =?iso-8859-1?Q?qkIBcJeSR85lKdc6JVTKjnymWzx4dhPlGXcMOmVHpDiVcODvy84XoZ19vA?=
 =?iso-8859-1?Q?rsiS8UO425yUlZzB/bmJ0XXUo5zxtJuP+ASQ7bttTVyVcWv8rn0Ug04yX9?=
 =?iso-8859-1?Q?FHOkBofWyrZB1A6Fw8Rv3soQkWwFv805wG8/2OO/ztl8FlkwCjSfVfX3Qr?=
 =?iso-8859-1?Q?7ta+6oUgAlRo6uQqaGTaEWebQUUMbF7mhUgeJKmy4sAXhso+1OizEWc870?=
 =?iso-8859-1?Q?N47RC4/V9QyM/2jjKTqzSMUng2a+Q9qtexDhPq+Qo11YjqDiVdh/doiGGf?=
 =?iso-8859-1?Q?utMHTDSXL3bU+iw6D6CzELrMB6LY61pDs6hoz13FBQjUZ4mfKSJb2yNnfR?=
 =?iso-8859-1?Q?82/QueIVmOzx1ejFP7jCP/elAFg1pBYlfvdh1+yTuDgQIAAe7ihfXMBNu1?=
 =?iso-8859-1?Q?DhTATPMOvBpWIVTrbORhG3TRia/8X35kKPMtL/S46PiqHlkvQaAw3N8R25?=
 =?iso-8859-1?Q?nRyhHQ6XWxEldG+T/lTJ1FIBp8K6ec2W5DQjrxKTLNAbVsrplJBZAqLce9?=
 =?iso-8859-1?Q?vq9U0DNC8yjtnQRZCnpFf881vbxkMOtVoYCfU8mXBGFaw+M3nr449bpnDs?=
 =?iso-8859-1?Q?qIGmckV+DkVHmvj3/ctn02kTdqbdAvBnaYItZ1rWXoJWs4qXYJ1UsmUjpw?=
 =?iso-8859-1?Q?GeGB/wzThmlKYdWhtvsN0JBNQbYTe1ZH8D8E+0i8PDqV8D71Mr35xcRfzi?=
 =?iso-8859-1?Q?WtzDAfGQlkAj4OOtAvygcuyTrK2vyO6ss3tCHD0jpvba29iyAMJxYCbKG+?=
 =?iso-8859-1?Q?w5ELAWO/hsrNSfLYPgjkWziv/hV7NdoR60shxlV9dRs5Ywvg+EUdvKY+rB?=
 =?iso-8859-1?Q?7Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:OSPM;SFS:(13230001)(366004)(7696005)(52116002)(40160700002)(19618925003)(38100700002)(6200100001)(558084003)(38350700002)(26005)(8936002)(8676002)(4270600006)(40180700001)(9686003)(6862004)(66946007)(7406005)(66556008)(7416002)(55016003)(7366002)(66476007)(186003)(86362001)(2906002)(508600001)(7116003)(3480700007)(33656002)(62346012);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6m47vHuf/0UBnw9LibOUdsnIfmAruF36JKfn1tgu4grukT4hnZWiw5hvE9?=
 =?iso-8859-1?Q?9Vv9ls/8Fdx709ZJdfi0AtnYCnY3DnppEVWL/3JwZpZpqAMd+AOSLonxgZ?=
 =?iso-8859-1?Q?j44XCnFpe0KXi9D/V+11FBhM64kJXv/a/KI8MRje1MWhEYjFEka1OrJzo4?=
 =?iso-8859-1?Q?HGeQ6tuCkcXxCyEw5ObqL8y8XLjCh6ggbAN0Siktlc3NYgcVC9iD9qDryp?=
 =?iso-8859-1?Q?+HCJLqZM1j9QBMuzJUR4tYsHLdSIij0JwdH9ybyEyoBbUSySTQTgKk0Mpf?=
 =?iso-8859-1?Q?sJQXUrASo0euRv2NTSAjnEF50OdOI9MoHsM9j86I8wQwN0pDhf25jeCPlJ?=
 =?iso-8859-1?Q?PJKCzbozxjy7xKoDRMNdYgd60GH0RU07edJnjK/DMndUDLDoRhpPJKIQHc?=
 =?iso-8859-1?Q?um4U9qnjP/yTmhhGGJ0bV/+ZXe99ZcnpjlE9GhNHM85Bv12SkZM0ousRl2?=
 =?iso-8859-1?Q?j5hb2r5OmOvzYrpSUPc8hB6low05FFDDBCyRdF/PDmjnhm10URBsOszZmS?=
 =?iso-8859-1?Q?Wf8Zep1qfz897pLFq6JALjGHmmIllqp5N5OeyLFWkyOnZF/LTR32mjoZbg?=
 =?iso-8859-1?Q?QPsxrbuxJpRK35ZSmX6lZDEvqwgaAaLAnvkWnyO22S6mryutx4WYPszi78?=
 =?iso-8859-1?Q?a4F9MGxm0jYp8TE46NcIg7YypeGQme4quh+Hl3DEZUnY1o/RFcCJ8mo3uQ?=
 =?iso-8859-1?Q?2KhjgzlxS4zmXDO+8C2qFI3SQoa5kshmRK/bUuTIOZkp8hM+sQyDD2WfrY?=
 =?iso-8859-1?Q?HqnLi9Ya6ShG+UIsRIndFqrFxnKIKAWQvdVVeZMAl0r1LsXqn9lRqGaOOi?=
 =?iso-8859-1?Q?L/rvCHRtOaG8NN0AzYg2G32OxvN/7F2D2DEh4d2dZJhXz+rKK60AMG0WQp?=
 =?iso-8859-1?Q?4dgnhHteSpD7702Qwd+xVBwXQT8t1uQ5VLB7VeVfsj9gzAjeRG3dPTX3SQ?=
 =?iso-8859-1?Q?pG9YyFOnd1KEFSeSQijJ12hDt527v0eTjmZUyGQ47NL8VuanUF7GFtiuR9?=
 =?iso-8859-1?Q?tq2jN4xFxNyFbmuaGJdZqLj7Ibja8FxR9yyJM/rKIy6XZd0CX2F3IOYVCr?=
 =?iso-8859-1?Q?ad3RBmaTwUJsQz9Zzmj0zNxzxelisTeF0Ca50tIiXebIwgkW3kdc77h5l1?=
 =?iso-8859-1?Q?L0wYuAj3sOQz0c2EI6l8DNLqrnrSwioDsoybp9p5M5FXjthIN6hh5M3ZCd?=
 =?iso-8859-1?Q?dhLLAcb9iQ/D86VeUjgZpSUlg/+xJF/p4PuzF0UlvUrUTj7di6D2/+R9jb?=
 =?iso-8859-1?Q?IfM7EUwnkm6Ev9UEoTrpOqNFfOeg6K/ifwnW5KU7kaMDHBe7pyim7Go2A3?=
 =?iso-8859-1?Q?2rA7iOiWLwIdGh4cJzn9BbdeSy3FHGfYq5iLYHlIVcb2oNSAYjmK2mp/f0?=
 =?iso-8859-1?Q?E+IANm02fXX9Tg1NNNX8O+wQBlMMgy2Zu5aZlunScS95YdBd3R4sDjm1/v?=
 =?iso-8859-1?Q?NwQSTv0rdTzvP7iDIftbNCTM6ociCiAETUViKxR/nGaIivR+bEG+7YD0Vn?=
 =?iso-8859-1?Q?eAI/Fu/lQT+W0SesbBwgZD/+GmcKA8cjpUMFe6c0Ofl4xa4uIU64/GrPVu?=
 =?iso-8859-1?Q?HGH5toj4UVlzAGpZ82NknoLtJRJIZK78+fQHMO1sWbpUZ828sh7nVWoB19?=
 =?iso-8859-1?Q?WUfT6ORQ2koZBzLDRbeI/EKirVHyLDRCFxVSXDqSoyoZ5xuDe46LIgHaVH?=
 =?iso-8859-1?Q?eU85FZCjjzu5cW1bHrpVXR1iU0zaRt3vZH7Ur58OZw25PB+tAz2Vzl7r8v?=
 =?iso-8859-1?Q?WDLQ=3D=3D?=
X-OriginatorOrg: gientech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ca1767-fbf2-4795-4231-08da39141d61
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 21:19:38.2482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 89592e53-6f9d-4b93-82b1-9f8da689f1b4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0DUz4TNoHO9cM0vkzNpHWdemcLULpCXtHA3c6a0BN6Aea57Y2GajnwScipA1Nv/Q+ZyJyP/DCFexWvIgzQlyc256IuC6ZL5cypLU3ro7vM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0575
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DATE_IN_PAST_24_48,
        DKIM_INVALID,DKIM_SIGNED,FORGED_SPF_HELO,KHOP_HELO_FCRDNS,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Can you do a job with me?
