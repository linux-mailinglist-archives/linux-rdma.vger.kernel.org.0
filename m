Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62953C407
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jun 2022 07:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiFCFNa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jun 2022 01:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiFCFN2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jun 2022 01:13:28 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AB91DA7A
        for <linux-rdma@vger.kernel.org>; Thu,  2 Jun 2022 22:13:27 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id i185so6427356pge.4
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jun 2022 22:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jb0TyXV/oidz5qukxyhvHi03iGINx4MErOAqfXOcPIw=;
        b=4XIAKM3wXtGIwrIXwe+lpLRYl+yaB+ypNiNeurd5JwwTzurBeo/WV1KMsRQ8GehBRU
         MwDPd63n8MFeBmvWqM80MhZ6iIctoGRBIr+D9JX1XM709xUuNJLEABsJmcKoEpqlH2vg
         0QW1h2rbvlC4GQ2Bc5JnTII3G4vwXFJdpE1HVrNIH0uIqVk3IVwSmMhfg5kdS11fpdO3
         836ttdGFmO7AalN19I1kOMWQ9JvCKhtHjjJHyRcPIdoGaJ33ua/omIz5O5BlRqmzExno
         FdYCwgPdvxxKBysfJPqLHUbSGsmP/ddKPDOHsI8I1jpVl1qX4t0IkQf4i4aauPwnf2or
         bztg==
X-Gm-Message-State: AOAM531Fh+DlJIc5V26VZcqqvPmC9JV8oQWrik0FVcwZfbwfsVR/JdRB
        GysPVJMHaTavnEBxhDRBb7E=
X-Google-Smtp-Source: ABdhPJzFOd4NjGVQ84m9d7+jzM5PYR54oZz8DWO899//Yo+LWlC/Zcc6Hdi0Lm+A+1axrMB+fF6nrw==
X-Received: by 2002:a05:6a00:c84:b0:518:e0f6:f1af with SMTP id a4-20020a056a000c8400b00518e0f6f1afmr8682097pfv.47.1654233207164;
        Thu, 02 Jun 2022 22:13:27 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id o5-20020a170903300500b0015e8d4eb2e0sm4302862pla.298.2022.06.02.22.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 22:13:26 -0700 (PDT)
Message-ID: <53951a52-dc77-f4c9-a1dc-d6ac015be1a4@acm.org>
Date:   Thu, 2 Jun 2022 22:13:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
 <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
 <20220601124556.GI2960187@ziepe.ca>
 <109ac246-5cc0-8d5a-ac0a-2937d86fbe06@acm.org>
 <20220601173005.GJ2960187@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220601173005.GJ2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/1/22 10:30, Jason Gunthorpe wrote:
> That is just the keys, not the graph arcs. lockdep records an arc
> between every key that establishes a locking relationship and
> minimizing the number of keys also de-duplicates those arcs.

Do you agree that this overhead is acceptable since lockdep is only
used to debug kernel code?

Thanks,

Bart.

