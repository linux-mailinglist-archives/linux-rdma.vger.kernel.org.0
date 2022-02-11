Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE24B2D3E
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 20:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbiBKS77 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 13:59:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiBKS76 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 13:59:58 -0500
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2D2CE7;
        Fri, 11 Feb 2022 10:59:57 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id p6so5213844plf.10;
        Fri, 11 Feb 2022 10:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YVf2MMefe7JarpYrftbPjGY+T6Frea6p9y08VS6g0s4=;
        b=pL2UdlhEh/5x5FBC82s1/CfS7zQyfjHH3kcRZr4ppYA4uu1dAla5pcxOOuDrFYvXxb
         /U9xEVTwipyIFowfz8N0q51hXAwCBJlpbjzFRLblMnz9bIWH2R5r8xZe6f+4gR4DVOKk
         td1iTLwZpMxwGxrTHfxA8djyYEpdvvbGPhZWYLC566pt5EzYHcpzkkO3hJodJvl/1+CB
         Zri+nq9J+9qkfy8O/wTi6PJ1E4ERlFpXxaxmn4eOeHFM0AbAPftuI9QMDoXVeCeAlUfw
         2BNUhfmE4xzVlWTgVRGynlWe1wKDFLnavLfTBCLCiVYd8F5ClzMrENrBipIx7uwJZC1n
         v0mA==
X-Gm-Message-State: AOAM532h08+i/oTedm3Ar0+3GiFp8I+fZ7/fzVY3JIvxSj/XH1nOR5UC
        hJWv4UaoO+rdDr/t0qFzbsLdC8WzxxDqSA==
X-Google-Smtp-Source: ABdhPJwkyLc1MFtmoGkbxDrARkdlH+igPcIeSSJO06I0oobmySyyqX0rEHvpJfh5h5MLxvjX/vVM7w==
X-Received: by 2002:a17:903:32c3:: with SMTP id i3mr2808782plr.46.1644605996745;
        Fri, 11 Feb 2022 10:59:56 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id oo7sm6691567pjb.33.2022.02.11.10.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 10:59:55 -0800 (PST)
Message-ID: <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
Date:   Fri, 11 Feb 2022 10:59:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [syzbot] possible deadlock in worker_thread
Content-Language: en-US
To:     syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000005975a605d7aef05e@google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0000000000005975a605d7aef05e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/10/22 11:27, syzbot wrote:
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.17.0-rc2-syzkaller-00398-gd8ad2ce873ab #0 Not tainted
> ------------------------------------------------------

Since the SRP initiator driver is involved, I will take a look. However, 
I'm not sure yet when I will have the time to post a fix.

Thanks,

Bart.
