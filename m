Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58957533386
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 00:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbiEXW2R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 18:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbiEXW2G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 18:28:06 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77BA52B37
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 15:28:02 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s188so19305079oie.4
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from:to
         :subject:content-transfer-encoding;
        bh=hyFh1SbqWrQdGYmE092106zoC6Tsn7p5s/wOyXle7TI=;
        b=OWspICcRmSFkAtg9QP3hVW1Y/yNREJuNkVaXIgO+2hjID2A3ghtFwORWk/Fk2HDyDp
         1UPjPxyRDnz/pZ54ZV/OhlGilK9xHn+ZTlr7Mveyzvk6cAcLGJ4k+YhOF8AEmnJymN4W
         nS0+hiGaJviusE28lI/VB/2vlZ/h1+GNEZZhV7NN1gEHTl+oVzmdaMsNPjqiGaxxDuGD
         oPiyPs0AXukdsb/2LNNGRN23ltwjEc0OgxZknjg3VVUVSnkprKDCQ2lsnUBHB/Bq+erI
         n0QiU9D+G/ba7l5/8O7rrQvUlDrzywFvis3/e6SLl0mZr6gqIesW8UKP4jUbwb4KMdAN
         lZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:subject:content-transfer-encoding;
        bh=hyFh1SbqWrQdGYmE092106zoC6Tsn7p5s/wOyXle7TI=;
        b=u3cRL082AVLGQ1EzLqI2i/tYLi7k5sPkMydfMXOLrmDWN1d0GOF12W+GVn0A7rT9ye
         XlZupEjsuW07nSdEs6B2G4XFyXBrdubaMNxegsfAnfhiND/ckiqqNBx0wBo8FsaVhQAV
         4ry9lcGh4/Rhxls1ZMMUgmbK7/g7SGfu0DtWd+Jw2YzLZwKGEuoKsDWrPOVaRBomZLxr
         tYiv1Oo8CwPmluvTzkg/3LqYZ6sfNGJFCzfJ3/nEJmFyTteQGudRCCkEFL0UNNkraKnP
         tASszskwIqBH3WVJWmLubvosn8eGoAuKXOpNsNIodBiRLgxMd/KPuxQY7iil28QsCL/j
         v6mA==
X-Gm-Message-State: AOAM5319ITiHRNrQHiRl+sfNfBsJyRNpTeyxXTwqD9qGciNfm9IEov/7
        zj6q8mH7kAqNZN0A6gVzkjk=
X-Google-Smtp-Source: ABdhPJyySIZz8qlfJ6yHGun7Jfaf+zUaiQ1/UL4MMGWks0+zPOkz0h9KRg3dQzcujui4SXOUt3ilsQ==
X-Received: by 2002:a05:6808:1206:b0:2d7:65a8:65e with SMTP id a6-20020a056808120600b002d765a8065emr3598276oil.107.1653431281337;
        Tue, 24 May 2022 15:28:01 -0700 (PDT)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id p7-20020a05683019c700b00606ad72bdcbsm5451619otp.38.2022.05.24.15.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 15:28:01 -0700 (PDT)
Message-ID: <78918262-6060-546b-134d-2d29bbefb349@gmail.com>
Date:   Tue, 24 May 2022 17:28:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>,
        Frank Zago <frank.zago@hpe.com>
Subject: [RFC] Alternative design for fast register physical memory
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason,

There has been a lot of chatter on the FMRs in rxe recently and I am also trying to help out at home with
the folks who are trying to run Lustre on rxe. The last fix for this was to split the state in an FMR into
two with separate rkeys and memory maps so that apps can pipeline the preparation of IO and doing IO.

However, I am convinced that the current design only works by accident when it works. The thing that really
makes a hash of it is retries. Unfortunately the documentation on all this is almost non existent. Lustre
(actually o2iblnd) makes heavy use of FMRs and typically has several different MRs in flight in the send queue
with a mixture of local and remote writes accessing these MRs interleaved with REG_MRs and INVALIDATE_MR local
work requests. When a packet gets dropped from a WQE deep in the send queue the result is nothing works at all.

We have a work around by fencing all the local operations which more or less works but will have bad performance.
The maps used in FMRs have fairly short lifetimes but definitely longer than we we can support today. I am
trying to work out the semantics of everything.

IBA view of FMRs:

verb: ib_alloc_mr(pd, max_num_sg)			- creates empty MR object
	roughly Allocate L_Key

verb: ib_dereg_mr(mr)					- destroys MR object

verb: ib_map_mr_sg(mr, sg, sg_nents, sg_offset)		- builds a map for MR
	roughly (Re)Register Physical Memory Region

verb: ib_update_fast_reg_key(mr, newkey)		- update key portion of l/rkey

send wr: IB_WR_REG_MR(mr, key)				- moves MR from FREE to VALID and updates
	roughly Fast Register Physical Memory Region	  key portion of l/rkey to key

send_wr: IB_WR_LOCAL_INV(invalidate_rkey)		- invalidate local MR moves MR to FREE

send_wr: IB_SEND_WITH_INV(invalidate_rkey)		- invalidate remote MR moves MR to FREE


To make this all recoverable in the face of errors let there be more than one map present for an
FMR indexed by the key portion of the l/rkeys. 

Alternative view of FMRs:

verb: ib_alloc_mr(pd, max_num_sg)			- create an empty MR object with no maps
							  with l/rkey = [index, key] with index
							  fixed and key some initial value.

verb: ib_update_fast_reg_key(mr, newkey)		- update key portion of l/rkey

verb: ib_map_mr_sg(mr, sg, sg_nents, sg_offset)		- create a new map from allocated memory
							  or by re-using an INVALID map. Maps are
							  all the same size (max_num_sg). The
							  key (index) of this map is the current
							  key from l/rkey. The initial state of
							  the map is FREE. (and thus not usable
							  until a REG_MR work request is used.)

verb: ib_dereg_mr(mr)					- free all maps and the MR.

send_wr: IB_WR_REG_MR(mr, key)				- Find mr->map[key] and change its state
							  to VALID. Associate QP with map since
							  it will be hard to manage multiple QPs
							  trying to use the same MR at the same
							  time with differing states. Fail if the
							  map is not FREE. A map with that key must
							  have been created by ib_map_mr_sg with
							  the same key previously. Check the current
							  number of VALID maps and if this exceeds
							  a limit pause the send queue until there
							  is room to reg another MR.

send_wr: IB_WR_LOCAL_INV (execute)			- Lookup a map with the same index and key
							  Change its state to FREE and dissociate
							  from QP. Leave map contents the same.
			 (complete)			- When the local invalidate operation is
							  completed (after all previous send queue WQEs
							  have completed) change its state to INVALID
							  and place map resources on a free list or
							  free memory.

send_wr: IB_SEND_WITH_INV				- same except at remote end.

retry:							- if a retry occurs for a send queue. Back up
							  the requester to the first incomplete PSN.
							  Change the state of all maps which were
							  VALID at that PSN back to VALID. This will
							  require maintaining a list of valid maps
							  at the boundary of completed and un-completed
							  WQEs.

Arrival of RDMA packet					  Lookup MR from index and map from key and if
							  the state is VALID carry out the memory copy.


This is an improvement over the current state. At the moment we have only two maps one for making new
ones and one for doing IO. There is no room to back up but at the moment the retry logic assumes that
you can which is false. This can be fixed easily by forcing all local operations to be fenced
which is what we are doing at the moment at HPE. This can insert long delays between every new FMR instance.
By allowing three maps and then fencing we can back up one broken IO operation without too much of a delay.

Even if you have a clean network the current design of the retransmit timer which is never cleared and which
can fire frequently can make a mess of MB sized IOs used for storage.

Bob
