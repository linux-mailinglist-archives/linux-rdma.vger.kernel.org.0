Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCA77B245A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjI1Rta (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1Rt3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 13:49:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA0DD
        for <linux-rdma@vger.kernel.org>; Thu, 28 Sep 2023 10:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8SBqfF6aGvdwCl0P7FsDmwkpFw3+EN5rqym+H82MImmF/SYK58Qztu3b36ipXPwTVJTKFMP4NYWybyGZkxmGiNQ8C8W/sIEsSswXuNiAfE7LnFbYexlyYw4z4Zvv5ZkCSYTGo07UDs+9F8nCdITlNXyKsO/Jyp+q93S1yWfiJ+RmPI4CsAM25Ipssqhwle6fxumaU64Wg1JzsndUXg53civQy2Qtj2QegbgF0Jm6o8fDg4wIwUOyiA34NJ9MqNVPbiuXw9Q/vIi0JvyP0jdTU/GqQ+MThCoKWaRNZ1CwmwHaGyQ6aIsy+MwB5nGpQqmj/cCdG31cmopQJpTzeiFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UWnkkgb1FPIHarnTrAjdbEZQK8e7Ou6s1x+kOHkpKo=;
 b=PbGL9I3YybfYzFlblWTsEGzKnLJRnOrksoQjybRTRLLcuUIy/zSKOWoHLAvvP3Ryopy74134LTq4uJRodkXZWd5389VCGiRPaoJGhmOco0CTYX35zh5pJ2iDIRBt9QPirpNtnsn32+/BNp8P6UD82jD9peEN2V02BiQJcuVPbxIoOxnFIDY6rtQ+i+q39jBg9Oa8N0X3IxHnwLREhT4I0RC361cZKsrGcU644qE3vut3zVAZfBbxzYAEEMILnljOeLEwIREpNmtsBSh/ZdGnx7MS72uWV/RG7SgDm7fpZRAFpih2Lethx5+RwV/FegYwbEG0z/pi4Dv2wguHInQnkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UWnkkgb1FPIHarnTrAjdbEZQK8e7Ou6s1x+kOHkpKo=;
 b=NGH6kuEPAoBnslZltAA9P/+EMJ58ShaHK9ibVu2Id9uOWcttCxr78Ypgh4JYgIVMYE3cEYcKb3+SIXTcCeoK8MoeAm9sHAaLMkBkk+iY+Z4lsLEHkXQg3N0zCmhCxacd1hOFSqNuUlchQCk0AeP3sWyqghr/E1lS/V1Oy+4f+dHXKdWFjJwYogiI2DbVQ+8LLgCC1G1e38Y+gCkBAvTkLN9dm3IMp4Ks3ywmLtpd6Ybf/i9Kklk7HUYQIhqolGvVbl78rRagd40WQzNIgsIcEyyYOE6mun6tY5IJRehKCiKMy0QYa9kwYPBJm9Z5c1XcWHHES//2J5fJAlKwQLNrKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com (2603:10a6:7:1c::23) by
 VE1PR04MB7389.eurprd04.prod.outlook.com (2603:10a6:800:1b1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Thu, 28 Sep 2023 17:49:25 +0000
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::fef6:bde:8f08:e85b]) by HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::fef6:bde:8f08:e85b%5]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 17:49:24 +0000
Message-ID: <cf5c0c73-46dc-4091-a578-262d7629f85f@suse.com>
Date:   Thu, 28 Sep 2023 19:49:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] rdma-core: new stable releases
Content-Language: en-US
To:     Mark Haywood <mark.haywood@oracle.com>, linux-rdma@vger.kernel.org
References: <4410ebe0-c4cb-98ce-e493-0c6cd9a57b74@suse.com>
 <7659c824-ad3e-eb6c-1928-fd438fa68e70@oracle.com>
From:   Nicolas Morey <nmorey@suse.com>
Autocrypt: addr=nmorey@suse.com; keydata=
 xsBNBFjZETwBCADEkoe7QWAXzd9xpSiPbQK6P2F4wKdxyTp6r0aN4I0O+4fc8xWXvmwOrCjF
 UsuoGZ3CxJaHgdB/3ueW/IhMO5Ldz7pylhKVlG/moUh4CBK2eRUdaG7mHID01GyJMtR3VQqu
 22hJhHPYy0erpYViyr+I4MzQA9QZLoQhSxn4imjZOZPcj20JE+lRfXppNv9g7vQiRLMcXjTi
 KcnrqG5owOi6Cn1sZ201YfdeztGxKA+jvjWO+6absTTlorIlZNGUf85s2+caGDsqa31u2DPs
 hVv5UUTy1g/5aP2wacSWI3Qm4n2MWl1aCnHN2h737PCXXfBk5iGJsgBUnSQULgdgEAt1ABEB
 AAHNH05pY29sYXMgTW9yZXkgPG5tb3JleUBzdXNlLmNvbT7CwI4EEwEIADgWIQRC0lOFwaHA
 K4sbHG+AG924JZiPZAUCY5G8SAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCAG924
 JZiPZMZiB/9QkcGfH248qvFUWZig3jssK5IgijfOFDKB0YK4e844M5C8LVSuWpu7Z+lM+cql
 3mbrikW6mlZjPEusrQ/KGvT6TdfOM9VCQWjlshMzt7uiRDdzufHGtE5hhk/67UnkEVjmplpD
 k8cb1O0VsBfGym7e0nySHTlDWqr++9EcwgV3uo4psYYEqm6Aon1yKqjbmj+vfl/C5iW3V4lq
 DhBk8w21AvNS+tdEqJzhruxuXkEDZZ07wYFS7m8OxLNb4sMzn/Nz9x/NXeweBWx2ujIERtAq
 1e/hh0ZAcoPVR3CfO2QTmfTfrzVdpZrZ8F54337ze3+BUNnrFGObQhlNe26NqNYWzsBNBFjZ
 ETwBCAC9zAzCRlTgzyO9siVLQYwbRUhcL1TUJU/FiOQWQTmL3uDdBc6MgVBs+hp82RwPbbXT
 v4W4rghBYPKdmFXvRN+jvGDLq1f2hsuCSiE1ckTMzFV+sKoWRIEC12tEpw5ncEFGm+1k/rJR
 Lk9eHxuqn+yRjPryN8CK6tK4+b4tZ2urKlP29XG+T3l/mbUSoqfjqvyeKaW6xw7ku89EX2Xo
 QWP/pm92RxUd6VDU9vpVW/T7qPZRl0wtUnDnO2wePoZmvUfEr5Osh3MNvm1myG+v4EV2Hgva
 NT6pa27IptrUq06cA6dDsIKwPtMuThJQp8/xumgl5Q9A/ErQoJTrB9rclIm7ABEBAAHCwF8E
 GAECAAkFAljZETwCGwwACgkQgBvduCWYj2QwNwf/eOIpFB67cKoUJvcm3JWcvnagZOuyasCw
 xwH9a0o9jORcq+nsJoynS/DpjUKGyZagy7+F7sBrF7Xx0cXF2f5Bo42XNNiQDE5P/VLwvgn9
 62AJ3q0dp4O7oQI8UgNmdsocQhNaBHHCoOabLGrgNobDTaLBeb9zaOZqz8CBuAiZ0bVABEpg
 50hDEYTHp4jCgWpadhAsp/eCgm93Tc+Y+e1fqtE3FmoOLxyhFa6evhn0Q1iX0kCasMZwlzse
 zqLZjTM1Koqn6+UIHXE3QaULyFKD1GDhisXxyolOB6P2TXsyfvitYdIZ3CCtI7PVDxzmX2Xk
 kvEz9bMtStoMpse9qAsmHQ==
In-Reply-To: <7659c824-ad3e-eb6c-1928-fd438fa68e70@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To HE1PR04MB2969.eurprd04.prod.outlook.com
 (2603:10a6:7:1c::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR04MB2969:EE_|VE1PR04MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: d835529b-7bb5-49cc-207c-08dbc04b401d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAXCCGlKpGsTRtxqE1z2ixL8gOJe8WfZHOXqQHwD2Jlddjdk/9zBCAPwfDhBuFR7J8pp9nu/tNzj2Je9lz6SVWwED0YCHyJNl2gofH2sQir+gQ/rAdxCaHqWEVJnWUFuna9Da+Hl9FOHRtZvNwJNuYjLd+tiZHX6w3Fl3BTmJcrPFUHtLjp8vlKcfHKqXKSecqV6YwNt/t381qsMB90P90ktyeFQAa9Eph+dN9Qhff0HjSiXM7yE4TKAUzakFEy0MkfQk3ksFtT1m7gX7pk/0OqaW9kmQf+zOBUvEHaNoqmx3Nq+J4sh8lCyeH1SS2992/lkRnw45ovvIUoAdAuRRcTO7GQHXhGLtTdKo7IkJPBIIalGE53cus0RrkI9P0HFHZ82T2jt9VWEqytIbnruqoponRAhg2HeQMJAZsYIe5FmnNoRCplwZYyvKtf+CHeZ7f8JjgXBlqAgiKH2i9YUNyz9nzQKLV1+KK39P8LH7m7oAdZyvzVPW8LJimILLq8UKIe0n4o8lwANa5fKXe3TjjbThbmZYvF974ektib83Zhd5YasBDpPRcHjYFakDI1/xipGo5F/rzAGGm6ITyStoUnqLau6vs1Lxo4q2LQhzUGVqR2sFIIVv6wYHwYkJ9RktjBEcPp05+CwLlgU/H7yYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2969.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(316002)(41300700001)(26005)(2906002)(4744005)(8676002)(5660300002)(478600001)(66476007)(66946007)(8936002)(66556008)(31686004)(6486002)(53546011)(6666004)(6506007)(6512007)(2616005)(36756003)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZMYndyUGNqb2VVcVFFcDFpMGhMZ1k0MXBlZHhGT2x1WWo4ZW9rTTFSdkFr?=
 =?utf-8?B?N3M0UTFsMGFzK25pT3NRb05JSUpqS1g0UUZ0a1JXZFFCN2xFMlQ4am43VUpt?=
 =?utf-8?B?ay9FOU41bGdibEZlNGE3a296VUNBRU00N1lkeGJNbWh4Mm42WGNlRTQvYmR5?=
 =?utf-8?B?THBTQU1aL05SY05lclFuWkswSjU2VVlwTTdzb3gyYU1zZEVZUThrOEFOSTVw?=
 =?utf-8?B?VE9KTHBoZE85Y3IvYmlXUkN3SFd5V0xwMytxRklzS2s2L1ZwUXNDaUFSR1pZ?=
 =?utf-8?B?NFZwRVJxVEt4SHY3N3ZLUGMwdlhyYk0rc2owZGhvUDJBY1lHY3hqY0RkWWIx?=
 =?utf-8?B?NVhINGdZRDJWUjBob2NWSWg5Wm1oQkIvbVFzaHhWSjhtTEUyaVdGeGVyNUNQ?=
 =?utf-8?B?OGMwSXIvU3RoVWFUVFZheituZE9aYm1scEdLeG1NZkNJcUhwQklsSEx1UWRw?=
 =?utf-8?B?UXYrdnVmVW5KaFEzYzZyYTEwenVNK0RBdVBmVlp6WDRiZHFCQTgzT091ZVNl?=
 =?utf-8?B?eVVndjRxd1pFMTI3aXROeUJvSUwrRFdtelNWcHUxbXBJQithTDNLcklvaTBm?=
 =?utf-8?B?RFRIa0E2WC9tRFdJbzlHK0NzTUhoMmgwTDB0bTZoanNkc2VKaFkxOWh6b1dY?=
 =?utf-8?B?MUlMd0M1dnZyVS9YZFdqV2lhOTZ5SE5vdTRza1p5M3FwM2xiMjFsOVB1VUxW?=
 =?utf-8?B?Sng0UERjV1hZNjR2RjhJWHJWenRmMHFFVjh4QXFudmNkditJMUxNV1I2MTZm?=
 =?utf-8?B?WGhpZ3VEZ1NOWmFvZUdDZTY2c0FTMXZhSGJnNDZ1ZUVxd2dlUkV2RWxDbHAz?=
 =?utf-8?B?Y2dCSGV4Tk4yblcyWmxMWFdEMFQ1bHpUSmFnNXQ3N005dm9aMEVkdHQ2Y2Ni?=
 =?utf-8?B?endacHBjYm5Fdm5hMkdiNlFyWkhUeUVQWDN6Q0NTL29EdmJUSTNTOWVyYmRj?=
 =?utf-8?B?cExLMUlKUXM2ZVBYQmoxMkpScVF5VVd1OVpudjZBcHVLZjV3Uk5pUmYyamRo?=
 =?utf-8?B?djBabHBBL2ZTdWtuM3JyZ3A0VUdtM0MwSkdlTHQwMkdmeld6UHZDdFA5dnZV?=
 =?utf-8?B?aUU1UDJmZ0IyRmFUVit1MVAva0hKSmlBdmdabFZUZ2l2YXZQYVJEOHgvWU1w?=
 =?utf-8?B?MFk5Qm9sK0d3d01WejdEcUkyeWVOT2cwMGFJL29HdHFOTFF1M0wrbFBWYkxa?=
 =?utf-8?B?Z0JYTzBCeXZSRmlwMW1WV0xuMWhHdUlGbW1XYmpsT2E5b1FJVTlPSHFyMEQ2?=
 =?utf-8?B?dnpnT0I0NE9TcHhURFl4cE9IRGJGUlJXMTZjcEhlMGdkaTBhcFFOeUt2dmxS?=
 =?utf-8?B?YjEzVWlXNHN0QkppRmZPWVNIWTNqWHZXNitqVU1HL3RaVUxaTFN2Wi8xZWIw?=
 =?utf-8?B?SkNtazZIL2UrTllQRnB3eEIyWmxmeWt1NVowblBGMkJMdlRRNGFMWWxsL2JJ?=
 =?utf-8?B?WWVocnFaS25KSllEY3VqQ3lSVG93czBHSDdpWnRlVlJlS3pUMGdIT1pvYW1G?=
 =?utf-8?B?QlFPMFNsT2oraFZ0RTNUeFhaSmFOQndxOEYybUFKMXRmcHRveGZJcHdMbXg5?=
 =?utf-8?B?TjE0bGJNN2poYXA3SjdWRlVPM0phM3BoRnZVZTVHeWFhWXdHRnh4Zm81MUJZ?=
 =?utf-8?B?QWlhOE8xYkxFL0RKQThyTkpXbEJEMU41amRjUSs1RytlTmpja3Zra1RUUlUr?=
 =?utf-8?B?YWJqRzFGUkk5eUdwTnpPN0NpdGE4aW5WQ1drNlhYaUxFMUs2OVlFeTJ4NXJx?=
 =?utf-8?B?VnZEUTB5bHFKZHNRWlJOalhrUVVuYTJkaTNVenRvQzBRNXJWbmltdjgzcjhy?=
 =?utf-8?B?alNuY3NNcUErSlFIZ0xnUkUySzNqZkRQZ3VtSGoxKy9kU043RmhSNk55M3Jv?=
 =?utf-8?B?VnAramQybVVPZ3dUamxPMlR1SWgvcVV0cWo0THFYMHJHQ1h6eTF6cC85eWJw?=
 =?utf-8?B?V1ZxMGhzdnBoRWwwTTlCWUd6dkJRWW45ZEhXNloxdXZqaFc2dHJodzJxUHRF?=
 =?utf-8?B?M1JhdVc3OEZGV3lWd2dNWHpJSkhwZU9lT0N2VExWOUtRbUxJUWRXbFF2VXAw?=
 =?utf-8?B?cDcwK3pxRnQ5T2hxbWhEdlRiVHhLWm9IMEhQZ2RFODJPaFpxeFlXVDhjekN2?=
 =?utf-8?Q?82uvcrZlCuFHCGDHd6F6D4dup?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d835529b-7bb5-49cc-207c-08dbc04b401d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2969.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:49:23.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Clk4kOtrKYWY4ybye++PzGjdA6+cIA8ABt9m1kqzWbavimH6kpcfpACcHClJySwsiLA6LjrVTIKPyUKg6qImXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7389
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/28/23 17:39, Mark Haywood wrote:
> I see v48.0 was tagged. Is it not a stable release?
> 
> Thanks.
> Mark
> 

What is called stable releases here, are released based on a vXX.0 tag where fixes from newer releases are backported.
But yes, v48.0 is a stable release in the sense it is a working release :)

Nicolas


