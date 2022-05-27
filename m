Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6399B5362EB
	for <lists+linux-rdma@lfdr.de>; Fri, 27 May 2022 14:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352963AbiE0Moo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 May 2022 08:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353214AbiE0MoX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 May 2022 08:44:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7980141F8F
        for <linux-rdma@vger.kernel.org>; Fri, 27 May 2022 05:42:44 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j6so4742023qkp.9
        for <linux-rdma@vger.kernel.org>; Fri, 27 May 2022 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QEFQvdnc1igsNXj4rOyzPFfHqQwBiqjxQbcN3hjdtJ4=;
        b=SHZqpLNdIG5/yK9rYAfN5L1onm2YYpB3cSMWQwV7Fjnm1Ss5K60Ra0JglCh/KuLbXt
         7Fb8Wa2ZCwwWlKnX1HtkGa0Ggq2urUZxR5C4loWZIUfiIwiUzG1c0uOEZ4EvUn9RRZBK
         8tSxnGacae5aVGswBwGNEESn8KXRoVKzwLICaiqHD4uVs1yZU5vfy8PaL+G2tNUqgXv7
         Wl6s/xIWHXMW+OLdROIEjyYo3Wx0OcBZtmqFV6G4oX//EXdl57rH70lS+82/rMA/wikr
         rjFmJHJcNOtcHx6m3ZdqEEmYcgWAE1nyWVCexs1cPxWB83lUH6zUWD36wwu4bZdtSOnU
         o7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QEFQvdnc1igsNXj4rOyzPFfHqQwBiqjxQbcN3hjdtJ4=;
        b=IVA44PxQV2jZ8ZmvttSVdAQACv+6HlT7Bv2mA24Cm7j8Y0RekppzLhI4bCmXkcZq9G
         yCVXLyXSeEIWZwBIHDtaAAg4mJy/Z1aAmeEyUpaiyd4V2JLoOdVesJ/88VTohOQ12p8x
         nLvfVEx9zmmZKl7BXO7YBVLK+CWu2Rt+knwYXpso3FKVIAoR023DzTqoUc8/EMooIZZK
         6ko0Knb8zmyelsMuDZYJA7LDyVP8GVhnoTd8HrR6BVQ0TF7HGt2l+wjit19NljIHMRWC
         qkaKbacUgQogDeHjnhCES+41JZWe27dRC1qqerWTbcCBsqjKhfqPpsYQAp8ckRdsgm3/
         kKtw==
X-Gm-Message-State: AOAM5308NNDA4o/6iucTX3V28fsb66UaUFUnydEq9zfHBbVETQXXDqTp
        Ww/Qwpl1NoE1SRo3sJVGpbjTmmelyPdj4w==
X-Google-Smtp-Source: ABdhPJwdFGfRKGRt0AAUzgyyrIs9u/hwTQoLNcPEpW/HewSI8VjBvW9IX3jF0NVoBsH/xVTPznBSvQ==
X-Received: by 2002:a05:620a:4102:b0:6a3:5f1c:f9d3 with SMTP id j2-20020a05620a410200b006a35f1cf9d3mr22706727qko.672.1653655363589;
        Fri, 27 May 2022 05:42:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l18-20020a05622a051200b002f939be4868sm2505431qtx.19.2022.05.27.05.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:42:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nuZIe-00DTLG-GI; Fri, 27 May 2022 09:42:40 -0300
Date:   Fri, 27 May 2022 09:42:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>,
        Frank Zago <frank.zago@hpe.com>
Subject: Re: [RFC] Alternative design for fast register physical memory
Message-ID: <20220527124240.GB2960187@ziepe.ca>
References: <78918262-6060-546b-134d-2d29bbefb349@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78918262-6060-546b-134d-2d29bbefb349@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 24, 2022 at 05:28:00PM -0500, Bob Pearson wrote:

> We have a work around by fencing all the local operations which more
> or less works but will have bad performance.  The maps used in FMRs
> have fairly short lifetimes but definitely longer than we we can
> support today. I am trying to work out the semantics of everything.

IBTA specifies the fence requirements, I thought we decided RXE or
maybe even lustre wasn't following the spec?

> To make this all recoverable in the face of errors let there be more
> than one map present for an FMR indexed by the key portion of the
> l/rkeys.

Real HW doesn't have more than one map, this seems like the wrong
direction.

As we discussed, there is something wrong with how rxe is processing
its queues, it isn't following IBTA define behaviors in the
exceptional cases.

> 
> Alternative view of FMRs:
> 
> verb: ib_alloc_mr(pd, max_num_sg)			- create an empty MR object with no maps
> 							  with l/rkey = [index, key] with index
> 							  fixed and key some initial value.
> 
> verb: ib_update_fast_reg_key(mr, newkey)		- update key portion of l/rkey
> 
> verb: ib_map_mr_sg(mr, sg, sg_nents, sg_offset)		- create a new map from allocated memory
> 							  or by re-using an INVALID map. Maps are
> 							  all the same size (max_num_sg). The
> 							  key (index) of this map is the current
> 							  key from l/rkey. The initial state of
> 							  the map is FREE. (and thus not usable
> 							  until a REG_MR work request is used.)

More than one map is nonsense, real HW has a single map, a MR object is that
single map.

> This is an improvement over the current state. At the moment we have
> only two maps one for making new ones and one for doing IO. There is
> no room to back up but at the moment the retry logic assumes that
> you can which is false. This can be fixed easily by forcing all
> local operations to be fenced which is what we are doing at the
> moment at HPE. This can insert long delays between every new FMR
> instance.  By allowing three maps and then fencing we can back up
> one broken IO operation without too much of a delay.

IMHO you need to go back to one map and fix the queue processing
logic to be spec compliant.

Jason
