Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 358B810F583
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2019 04:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLCDPB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Dec 2019 22:15:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbfLCDPB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Dec 2019 22:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575342900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=08LSHP3i4KAxSfFtz46KlYbHrqxFlYZ5I+U9GzefzGw=;
        b=eYomzYuURRWoBtVOOg3/YLFcaLr13PFkTkS64nv3YjRyDr7xJNrv452H3sBLXVf8VQ3drs
        Da31+S+dC2ULNVoKyFmbL2BmxdlDu1k6fD2mBAO4QqJ7Jv5WQYomfUJ9cui5j8l9TAWaw1
        2iP/yhAFq1dnCMz1yvfH4qFD1IvYG20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-2aGRxKaSPSulL06JJzt_Dg-1; Mon, 02 Dec 2019 22:14:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F30F2107ACC5;
        Tue,  3 Dec 2019 03:14:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA49B5DA60;
        Tue,  3 Dec 2019 03:14:49 +0000 (UTC)
Date:   Tue, 3 Dec 2019 11:14:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Stephen Rust <srust@blockbridge.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
Message-ID: <20191203031444.GB6245@ming.t460p>
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
 <20191128015748.GA3277@ming.t460p>
 <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p>
 <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p>
 <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p>
 <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 2aGRxKaSPSulL06JJzt_Dg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 02, 2019 at 10:04:20PM -0500, Stephen Rust wrote:
> Hi Ming,
>=20
> The log you requested with the (arg4 & 512 !=3D 0) predicate did not

oops, it should have been (arg4 & 511) !=3D 0.

Thanks,
Ming

