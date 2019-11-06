Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C268F1C8E
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 18:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfKFRgu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 12:36:50 -0500
Received: from verein.lst.de ([213.95.11.211]:52460 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfKFRgu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Nov 2019 12:36:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5475868AFE; Wed,  6 Nov 2019 18:36:48 +0100 (CET)
Date:   Wed, 6 Nov 2019 18:36:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Honggang LI <honli@redhat.com>
Cc:     jlbec@evilplan.org, hch@lst.de, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, bvanassche@acm.org
Subject: Re: [PATCH] configfs: calculate the depth of parent item
Message-ID: <20191106173648.GA20208@lst.de>
References: <20191104124322.31226-1-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104124322.31226-1-honli@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks,

applied to the configfs tree.  I will send it to Linus by the end of
the week.
