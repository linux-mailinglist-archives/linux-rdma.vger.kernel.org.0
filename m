Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7AA53E85D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbiFFQVJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 12:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241556AbiFFQVI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 12:21:08 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8882D5167
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 09:21:03 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id l1so10546330qvh.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jun 2022 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QqBjm6ExFDKoZI2vuwecpvsMHNF+qI+tR4Y3go9GTYQ=;
        b=MqKTNhkIrqgeKlshPnEt9mnekrzy5nY4sojkQp88ViEAn4jgcrViFfxWT+ZMDZ1a4x
         FU0ET05r68ad44m3NmD1uWT2M3Cfpw0E9TLnK7H+TnucOQo+drC2LJPocQus3Or6/MdW
         fnFJ7FcOhX27wi7oqlQmouDpoEk54spzYrbdjPRSXh9j2tdWA25tgrCyqa79EcJuhs6C
         OwPQxEmMQir60q+ULrSEwoPH0VFyCtQgreDZo90gNHqtM/TxLiuYSxQuRbk45i/qL045
         kBTxWy0XUG3XBkLHSHaJhKDrmtYo2xurejpYgLZ768vWuqCnvLeyOkhmpQ2jrKDPrGPz
         L+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqBjm6ExFDKoZI2vuwecpvsMHNF+qI+tR4Y3go9GTYQ=;
        b=OFXsJr1eaGAkWjMDtUIVlAayOczwe5wiAxD5hqPhMHdeyOcvTDEC0nmBrPA2qvwYNy
         qTiHcxmf2UGiHBO5HxflWodrZvU+aedFKZU0vZk9YxE5ySNfNVXzJEGMJxkDKBE0N6GB
         2gUCsHf3/c15MGRtP1+2E+wBM38rNjHoK2CoXtOYu/fHDL23zhvd12zj4wWSrfeXML1Y
         yPO5jEwC4w+QdeqaltNwv8Tmg9QQtYroi+NYWsj9/s9wSt1abe3mBrVochZBnrwibbuo
         458wduQSFwi2JxYx1yZnS1wWWGrjdObAI2Nb+wotD4JNg7x0T8sWM7Y6myxCoKPa6SOr
         REOg==
X-Gm-Message-State: AOAM533m08HqE77EMXa/L7FjkE6DFbwEFlMHjl7pOPvrbFbflxwKB5EP
        BrZFot/4OJwgN878jx/a76hcew==
X-Google-Smtp-Source: ABdhPJy41fQ9qZtPSyZLpy4jJpFiemjkZjeNOCmn8JnuAyqwUluHdgvFQhBtxzwwTORdIRANvNLPRA==
X-Received: by 2002:ad4:5ecd:0:b0:467:d600:7709 with SMTP id jm13-20020ad45ecd000000b00467d6007709mr15012890qvb.7.1654532462510;
        Mon, 06 Jun 2022 09:21:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a15-20020ac8434f000000b00304df6f73f0sm5666476qtn.0.2022.06.06.09.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 09:21:01 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nyFTR-002igF-5S; Mon, 06 Jun 2022 13:21:01 -0300
Date:   Mon, 6 Jun 2022 13:21:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Message-ID: <20220606162101.GA3932382@ziepe.ca>
References: <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
 <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
 <20220601124556.GI2960187@ziepe.ca>
 <109ac246-5cc0-8d5a-ac0a-2937d86fbe06@acm.org>
 <20220601173005.GJ2960187@ziepe.ca>
 <53951a52-dc77-f4c9-a1dc-d6ac015be1a4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53951a52-dc77-f4c9-a1dc-d6ac015be1a4@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 02, 2022 at 10:13:25PM -0700, Bart Van Assche wrote:
> On 6/1/22 10:30, Jason Gunthorpe wrote:
> > That is just the keys, not the graph arcs. lockdep records an arc
> > between every key that establishes a locking relationship and
> > minimizing the number of keys also de-duplicates those arcs.
> 
> Do you agree that this overhead is acceptable since lockdep is only
> used to debug kernel code?

I don't know lockdep well enough to know - if you bloat the graph too
much it may become excessively slow when searching for
cycles/edges. Debug workloads with CM may trigger creating of 1000's
of keys and we still want the testing to be workable.

IMHO it was not designed to have one key per instance.

Jason
