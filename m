Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD93C724A7E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 19:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238796AbjFFRpj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjFFRpj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 13:45:39 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7ED10F4
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 10:45:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f9baa69682so14841cf.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jun 2023 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686073536; x=1688665536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHwd4xj0DNhVRRocAAv9zxeTNWtRFM6WDQM6iXc8IWg=;
        b=eam6jhbQpY2JX8xLLkhv0yaMSMoLq31rBUfLkoZslsOiJRJkYcnUnvE95zvRBgiLS+
         7yyAitFM+fBVRJRMSziVoj+YSRV7nL9KfAb4jv4askxWgGt/54svqVeb1esLiHnL6nW9
         OGQ+JnnhznHN9rLPs9omFQ1pI+eUDZEZKQONbYUKhrZPD+9F3ZpvQsW2qxD3IYLdOgvD
         3E+JUVU2eMrcF0z6QmfuwC82NsXNcUC1DChPuQfVaEBaA7EiX+wuT+zJtewD4guLv+Xa
         2yk7nxZHgx/VKXUQ4MoGcyijrEUIwPvdNE2cohCzJD952ODv/I1RGLQAKX0y01xxsFlk
         m8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686073536; x=1688665536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHwd4xj0DNhVRRocAAv9zxeTNWtRFM6WDQM6iXc8IWg=;
        b=Qpo00UoCiSsWivfyRYjVGi9M7KFmK8vjXfxKX/a3ye9b0O7oZQ2kwwT6qpaZxPMHmK
         2ycxz8PlEeOiIkDA8YysKDYeHGHypC8PpZxHK53z7GrfjnOqmTehXgZcN2kg5j62hZSw
         4BlJhu3/yc1hfrlqjJ7uySF8iT0dCU5DJZ/TahtLgP+DjfJav/ICUtTUYCv/wa6ZiZwc
         VedhA2Cypq0PuuPuDwTMvCNFSrNn5i55IatqKo7zSxMbHukmn+BzZyDfVX4x1Di3NdY7
         nPYVG7ZOFXvd8x05m/wOMGjEVCUCZPSzOl8Rl3ll1IL9Tx+33h3puQwe20rlq0qe8XwL
         541w==
X-Gm-Message-State: AC+VfDwcPl+IE/l5vBdYCp3nqPajUehunG2NKDtNwpmurKyA70M4aiuq
        F4xPlTb5/j0dlAt39MEa8aBjIiRIjRVPVrTwwsQ=
X-Google-Smtp-Source: ACHHUZ4l8qvSLj+eigvYITUt4VH//gpwEqDw4vbb6W9i1DMdlyt2QosDSesRuk9286OHGFRVOruivQ==
X-Received: by 2002:a05:622a:1a1f:b0:3f6:6aae:a0a2 with SMTP id f31-20020a05622a1a1f00b003f66aaea0a2mr321894qtb.55.1686073536576;
        Tue, 06 Jun 2023 10:45:36 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id u3-20020a05622a17c300b003f9a77d1ba9sm1884198qtk.43.2023.06.06.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:45:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q6akR-00306g-2b;
        Tue, 06 Jun 2023 14:45:35 -0300
Date:   Tue, 6 Jun 2023 14:45:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, parav@mellanox.com
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without
 WQ_MEM_RECLAIM"
Message-ID: <ZH9wv6UNZtxhxrfw@ziepe.ca>
References: <20230523155408.48594-1-mlombard@redhat.com>
 <20230523182815.GA2384059@unreal>
 <CAFL455m3T4qrk0Uf5qK7-57Oh6L6AKionfs0mF-imUMYpbqBOg@mail.gmail.com>
 <ZHebeWlpn68Xa1Hd@ziepe.ca>
 <09504ea7-186d-9ede-e01f-87849673b9b2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09504ea7-186d-9ede-e01f-87849673b9b2@grimberg.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 06, 2023 at 02:01:04AM +0300, Sagi Grimberg wrote:
> 
> > > > > workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
> > > > > [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]
> > > > 
> > > > And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
> > > > needed.
> > > 
> > > Adding Sagi Grimberg to cc, he probably knows and can explain it better than me.
> > 
> > We already allocate so much memory on these paths it is pretty
> > nonsense to claim they are a reclaim context. One allocation on the WQ
> > is not going to be the problem.
> > 
> > Probably this nvme stuff should not be re-using a reclaim marke dWQ
> > for memory allocating work like this, it is kind of nonsensical.
> 
> A controller reset runs on this workqueue, which should succeed to allow
> for pages to be flushed to the nvme disk. So I'd say its kind of
> essential that this sequence has a rescuer thread.

So don't run the CM stuff on the same WQ, go to another one without
the reclaim mark?

Jason
