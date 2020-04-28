Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509261BC75F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 20:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgD1SBw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 14:01:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:40859 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgD1SBv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 14:01:51 -0400
IronPort-SDR: +Z1fLbI14K/MozSYife0iaocCqvRJgJXJKX3P1IV8TAwYnbO8sl+lzlpLR7ve62T8/vDbOGsyw
 uRIa6LYKEG+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 11:01:46 -0700
IronPort-SDR: VCFcKmm8Ve/I9oQq7utqTDnRMAY81ioG+Lt2vofzveJ9Q4jMfgar3XVxy+iAcrBEyYJjPPyPSM
 NymGjoj1oNCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="293938040"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Apr 2020 11:01:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jTUYA-000HQZ-29; Wed, 29 Apr 2020 02:01:42 +0800
Date:   Wed, 29 Apr 2020 02:01:23 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     kbuild-all@lists.01.org, axboe@kernel.dk, hch@infradead.org,
        sagi@grimberg.me, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH v13 13/25] RDMA/rtrs: include client and server modules
 into kernel compilation
Message-ID: <202004290132.C99ctgLJ%lkp@intel.com>
References: <20200427141020.655-14-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427141020.655-14-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Danil,

I love your patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on driver-core/driver-core-testing rdma/for-next linus/master v5.7-rc3 next-20200428]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Danil-Kipnis/RTRS-former-IBTRS-RDMA-Transport-Library-and-RNBD-former-IBNBD-RDMA-Network-Block-Device/20200428-080733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/infiniband/ulp/rtrs/rtrs-srv.c:508:29: warning: Either the condition '!id' is redundant or there is possible null pointer dereference: id. [nullPointerRedundantCheck]
    struct rtrs_srv_con *con = id->con;
                               ^
   drivers/infiniband/ulp/rtrs/rtrs-srv.c:513:14: note: Assuming that condition '!id' is not redundant
    if (WARN_ON(!id))
                ^
   drivers/infiniband/ulp/rtrs/rtrs-srv.c:508:29: note: Null pointer dereference
    struct rtrs_srv_con *con = id->con;
                               ^
>> drivers/infiniband/ulp/rtrs/rtrs-srv.c:1448:3: warning: Statements following return, break, continue, goto or throw will never be executed. [unreachableCode]
     fallthrough;
     ^
   drivers/infiniband/ulp/rtrs/rtrs-srv.c:1454:3: warning: Statements following return, break, continue, goto or throw will never be executed. [unreachableCode]
     fallthrough;
     ^
   drivers/infiniband/ulp/rtrs/rtrs-srv.c:1460:3: warning: Statements following return, break, continue, goto or throw will never be executed. [unreachableCode]
     fallthrough;
     ^
>> drivers/infiniband/ulp/rtrs/rtrs-srv.c:309:17: warning: Local variable 'list' shadows outer variable [shadowVariable]
     struct ib_sge list;
                   ^
   drivers/infiniband/ulp/rtrs/rtrs-srv.c:240:17: note: Shadowed declaration
    struct ib_sge *list;
                   ^
   drivers/infiniband/ulp/rtrs/rtrs-srv.c:309:17: note: Shadow variable
     struct ib_sge list;
                   ^
>> drivers/infiniband/ulp/rtrs/rtrs-srv.c:296:65: warning: Clarify calculation precedence for '%' and '?'. [clarifyCalculation]
    flags = atomic_inc_return(&id->con->wr_cnt) % srv->queue_depth ?
                                                                   ^
   drivers/infiniband/ulp/rtrs/rtrs-srv.c:420:61: warning: Clarify calculation precedence for '%' and '?'. [clarifyCalculation]
    flags = atomic_inc_return(&con->wr_cnt) % srv->queue_depth ?
                                                               ^
>> drivers/infiniband/ulp/rtrs/rtrs-srv.c:620:29: warning: Variable 'rsp' is not assigned a value. [unassignedVariable]
     struct rtrs_msg_rkey_rsp *rsp;
                               ^

vim +508 drivers/infiniband/ulp/rtrs/rtrs-srv.c

34a928cf49a7ef Jack Wang 2020-04-27  224  
34a928cf49a7ef Jack Wang 2020-04-27  225  static int rdma_write_sg(struct rtrs_srv_op *id)
34a928cf49a7ef Jack Wang 2020-04-27  226  {
34a928cf49a7ef Jack Wang 2020-04-27  227  	struct rtrs_sess *s = id->con->c.sess;
34a928cf49a7ef Jack Wang 2020-04-27  228  	struct rtrs_srv_sess *sess = to_srv_sess(s);
34a928cf49a7ef Jack Wang 2020-04-27  229  	dma_addr_t dma_addr = sess->dma_addr[id->msg_id];
34a928cf49a7ef Jack Wang 2020-04-27  230  	struct rtrs_srv_mr *srv_mr;
34a928cf49a7ef Jack Wang 2020-04-27  231  	struct rtrs_srv *srv = sess->srv;
34a928cf49a7ef Jack Wang 2020-04-27  232  	struct ib_send_wr inv_wr, imm_wr;
34a928cf49a7ef Jack Wang 2020-04-27  233  	struct ib_rdma_wr *wr = NULL;
34a928cf49a7ef Jack Wang 2020-04-27  234  	enum ib_send_flags flags;
34a928cf49a7ef Jack Wang 2020-04-27  235  	size_t sg_cnt;
34a928cf49a7ef Jack Wang 2020-04-27  236  	int err, offset;
34a928cf49a7ef Jack Wang 2020-04-27  237  	bool need_inval;
34a928cf49a7ef Jack Wang 2020-04-27  238  	u32 rkey = 0;
34a928cf49a7ef Jack Wang 2020-04-27  239  	struct ib_reg_wr rwr;
34a928cf49a7ef Jack Wang 2020-04-27  240  	struct ib_sge *list;
34a928cf49a7ef Jack Wang 2020-04-27  241  
34a928cf49a7ef Jack Wang 2020-04-27  242  	sg_cnt = le16_to_cpu(id->rd_msg->sg_cnt);
34a928cf49a7ef Jack Wang 2020-04-27  243  	need_inval = le16_to_cpu(id->rd_msg->flags) & RTRS_MSG_NEED_INVAL_F;
34a928cf49a7ef Jack Wang 2020-04-27  244  	if (unlikely(sg_cnt != 1))
34a928cf49a7ef Jack Wang 2020-04-27  245  		return -EINVAL;
34a928cf49a7ef Jack Wang 2020-04-27  246  
34a928cf49a7ef Jack Wang 2020-04-27  247  	offset = 0;
34a928cf49a7ef Jack Wang 2020-04-27  248  
34a928cf49a7ef Jack Wang 2020-04-27  249  	wr		= &id->tx_wr;
34a928cf49a7ef Jack Wang 2020-04-27  250  	list		= &id->tx_sg;
34a928cf49a7ef Jack Wang 2020-04-27  251  	list->addr	= dma_addr + offset;
34a928cf49a7ef Jack Wang 2020-04-27  252  	list->length	= le32_to_cpu(id->rd_msg->desc[0].len);
34a928cf49a7ef Jack Wang 2020-04-27  253  
34a928cf49a7ef Jack Wang 2020-04-27  254  	/* WR will fail with length error
34a928cf49a7ef Jack Wang 2020-04-27  255  	 * if this is 0
34a928cf49a7ef Jack Wang 2020-04-27  256  	 */
34a928cf49a7ef Jack Wang 2020-04-27  257  	if (unlikely(list->length == 0)) {
34a928cf49a7ef Jack Wang 2020-04-27  258  		rtrs_err(s, "Invalid RDMA-Write sg list length 0\n");
34a928cf49a7ef Jack Wang 2020-04-27  259  		return -EINVAL;
34a928cf49a7ef Jack Wang 2020-04-27  260  	}
34a928cf49a7ef Jack Wang 2020-04-27  261  
34a928cf49a7ef Jack Wang 2020-04-27  262  	list->lkey = sess->s.dev->ib_pd->local_dma_lkey;
34a928cf49a7ef Jack Wang 2020-04-27  263  	offset += list->length;
34a928cf49a7ef Jack Wang 2020-04-27  264  
34a928cf49a7ef Jack Wang 2020-04-27  265  	wr->wr.sg_list	= list;
34a928cf49a7ef Jack Wang 2020-04-27  266  	wr->wr.num_sge	= 1;
34a928cf49a7ef Jack Wang 2020-04-27  267  	wr->remote_addr	= le64_to_cpu(id->rd_msg->desc[0].addr);
34a928cf49a7ef Jack Wang 2020-04-27  268  	wr->rkey	= le32_to_cpu(id->rd_msg->desc[0].key);
34a928cf49a7ef Jack Wang 2020-04-27  269  	if (rkey == 0)
34a928cf49a7ef Jack Wang 2020-04-27  270  		rkey = wr->rkey;
34a928cf49a7ef Jack Wang 2020-04-27  271  	else
34a928cf49a7ef Jack Wang 2020-04-27  272  		/* Only one key is actually used */
34a928cf49a7ef Jack Wang 2020-04-27  273  		WARN_ON_ONCE(rkey != wr->rkey);
34a928cf49a7ef Jack Wang 2020-04-27  274  
34a928cf49a7ef Jack Wang 2020-04-27  275  	wr->wr.opcode = IB_WR_RDMA_WRITE;
34a928cf49a7ef Jack Wang 2020-04-27  276  	wr->wr.ex.imm_data = 0;
34a928cf49a7ef Jack Wang 2020-04-27  277  	wr->wr.send_flags  = 0;
34a928cf49a7ef Jack Wang 2020-04-27  278  
34a928cf49a7ef Jack Wang 2020-04-27  279  	if (need_inval && always_invalidate) {
34a928cf49a7ef Jack Wang 2020-04-27  280  		wr->wr.next = &rwr.wr;
34a928cf49a7ef Jack Wang 2020-04-27  281  		rwr.wr.next = &inv_wr;
34a928cf49a7ef Jack Wang 2020-04-27  282  		inv_wr.next = &imm_wr;
34a928cf49a7ef Jack Wang 2020-04-27  283  	} else if (always_invalidate) {
34a928cf49a7ef Jack Wang 2020-04-27  284  		wr->wr.next = &rwr.wr;
34a928cf49a7ef Jack Wang 2020-04-27  285  		rwr.wr.next = &imm_wr;
34a928cf49a7ef Jack Wang 2020-04-27  286  	} else if (need_inval) {
34a928cf49a7ef Jack Wang 2020-04-27  287  		wr->wr.next = &inv_wr;
34a928cf49a7ef Jack Wang 2020-04-27  288  		inv_wr.next = &imm_wr;
34a928cf49a7ef Jack Wang 2020-04-27  289  	} else {
34a928cf49a7ef Jack Wang 2020-04-27  290  		wr->wr.next = &imm_wr;
34a928cf49a7ef Jack Wang 2020-04-27  291  	}
34a928cf49a7ef Jack Wang 2020-04-27  292  	/*
34a928cf49a7ef Jack Wang 2020-04-27  293  	 * From time to time we have to post signaled sends,
34a928cf49a7ef Jack Wang 2020-04-27  294  	 * or send queue will fill up and only QP reset can help.
34a928cf49a7ef Jack Wang 2020-04-27  295  	 */
34a928cf49a7ef Jack Wang 2020-04-27  296  	flags = atomic_inc_return(&id->con->wr_cnt) % srv->queue_depth ?
34a928cf49a7ef Jack Wang 2020-04-27  297  		0 : IB_SEND_SIGNALED;
34a928cf49a7ef Jack Wang 2020-04-27  298  
34a928cf49a7ef Jack Wang 2020-04-27  299  	if (need_inval) {
34a928cf49a7ef Jack Wang 2020-04-27  300  		inv_wr.sg_list = NULL;
34a928cf49a7ef Jack Wang 2020-04-27  301  		inv_wr.num_sge = 0;
34a928cf49a7ef Jack Wang 2020-04-27  302  		inv_wr.opcode = IB_WR_SEND_WITH_INV;
34a928cf49a7ef Jack Wang 2020-04-27  303  		inv_wr.send_flags = 0;
34a928cf49a7ef Jack Wang 2020-04-27  304  		inv_wr.ex.invalidate_rkey = rkey;
34a928cf49a7ef Jack Wang 2020-04-27  305  	}
34a928cf49a7ef Jack Wang 2020-04-27  306  
34a928cf49a7ef Jack Wang 2020-04-27  307  	imm_wr.next = NULL;
34a928cf49a7ef Jack Wang 2020-04-27  308  	if (always_invalidate) {
34a928cf49a7ef Jack Wang 2020-04-27 @309  		struct ib_sge list;
34a928cf49a7ef Jack Wang 2020-04-27  310  		struct rtrs_msg_rkey_rsp *msg;
34a928cf49a7ef Jack Wang 2020-04-27  311  
34a928cf49a7ef Jack Wang 2020-04-27  312  		srv_mr = &sess->mrs[id->msg_id];
34a928cf49a7ef Jack Wang 2020-04-27  313  		rwr.wr.opcode = IB_WR_REG_MR;
34a928cf49a7ef Jack Wang 2020-04-27  314  		rwr.wr.num_sge = 0;
34a928cf49a7ef Jack Wang 2020-04-27  315  		rwr.mr = srv_mr->mr;
34a928cf49a7ef Jack Wang 2020-04-27  316  		rwr.wr.send_flags = 0;
34a928cf49a7ef Jack Wang 2020-04-27  317  		rwr.key = srv_mr->mr->rkey;
34a928cf49a7ef Jack Wang 2020-04-27  318  		rwr.access = (IB_ACCESS_LOCAL_WRITE |
34a928cf49a7ef Jack Wang 2020-04-27  319  			      IB_ACCESS_REMOTE_WRITE);
34a928cf49a7ef Jack Wang 2020-04-27  320  		msg = srv_mr->iu->buf;
34a928cf49a7ef Jack Wang 2020-04-27  321  		msg->buf_id = cpu_to_le16(id->msg_id);
34a928cf49a7ef Jack Wang 2020-04-27  322  		msg->type = cpu_to_le16(RTRS_MSG_RKEY_RSP);
34a928cf49a7ef Jack Wang 2020-04-27  323  		msg->rkey = cpu_to_le32(srv_mr->mr->rkey);
34a928cf49a7ef Jack Wang 2020-04-27  324  
34a928cf49a7ef Jack Wang 2020-04-27  325  		list.addr   = srv_mr->iu->dma_addr;
34a928cf49a7ef Jack Wang 2020-04-27  326  		list.length = sizeof(*msg);
34a928cf49a7ef Jack Wang 2020-04-27  327  		list.lkey   = sess->s.dev->ib_pd->local_dma_lkey;
34a928cf49a7ef Jack Wang 2020-04-27  328  		imm_wr.sg_list = &list;
34a928cf49a7ef Jack Wang 2020-04-27  329  		imm_wr.num_sge = 1;
34a928cf49a7ef Jack Wang 2020-04-27  330  		imm_wr.opcode = IB_WR_SEND_WITH_IMM;
34a928cf49a7ef Jack Wang 2020-04-27  331  		ib_dma_sync_single_for_device(sess->s.dev->ib_dev,
34a928cf49a7ef Jack Wang 2020-04-27  332  					      srv_mr->iu->dma_addr,
34a928cf49a7ef Jack Wang 2020-04-27  333  					      srv_mr->iu->size, DMA_TO_DEVICE);
34a928cf49a7ef Jack Wang 2020-04-27  334  	} else {
34a928cf49a7ef Jack Wang 2020-04-27  335  		imm_wr.sg_list = NULL;
34a928cf49a7ef Jack Wang 2020-04-27  336  		imm_wr.num_sge = 0;
34a928cf49a7ef Jack Wang 2020-04-27  337  		imm_wr.opcode = IB_WR_RDMA_WRITE_WITH_IMM;
34a928cf49a7ef Jack Wang 2020-04-27  338  	}
34a928cf49a7ef Jack Wang 2020-04-27  339  	imm_wr.send_flags = flags;
34a928cf49a7ef Jack Wang 2020-04-27  340  	imm_wr.ex.imm_data = cpu_to_be32(rtrs_to_io_rsp_imm(id->msg_id,
34a928cf49a7ef Jack Wang 2020-04-27  341  							     0, need_inval));
34a928cf49a7ef Jack Wang 2020-04-27  342  
34a928cf49a7ef Jack Wang 2020-04-27  343  	imm_wr.wr_cqe   = &io_comp_cqe;
34a928cf49a7ef Jack Wang 2020-04-27  344  	ib_dma_sync_single_for_device(sess->s.dev->ib_dev, dma_addr,
34a928cf49a7ef Jack Wang 2020-04-27  345  				      offset, DMA_BIDIRECTIONAL);
34a928cf49a7ef Jack Wang 2020-04-27  346  
34a928cf49a7ef Jack Wang 2020-04-27  347  	err = ib_post_send(id->con->c.qp, &id->tx_wr.wr, NULL);
34a928cf49a7ef Jack Wang 2020-04-27  348  	if (unlikely(err))
34a928cf49a7ef Jack Wang 2020-04-27  349  		rtrs_err(s,
34a928cf49a7ef Jack Wang 2020-04-27  350  			  "Posting RDMA-Write-Request to QP failed, err: %d\n",
34a928cf49a7ef Jack Wang 2020-04-27  351  			  err);
34a928cf49a7ef Jack Wang 2020-04-27  352  
34a928cf49a7ef Jack Wang 2020-04-27  353  	return err;
34a928cf49a7ef Jack Wang 2020-04-27  354  }
34a928cf49a7ef Jack Wang 2020-04-27  355  
34a928cf49a7ef Jack Wang 2020-04-27  356  /**
34a928cf49a7ef Jack Wang 2020-04-27  357   * send_io_resp_imm() - respond to client with empty IMM on failed READ/WRITE
34a928cf49a7ef Jack Wang 2020-04-27  358   *                      requests or on successful WRITE request.
34a928cf49a7ef Jack Wang 2020-04-27  359   * @con:	the connection to send back result
34a928cf49a7ef Jack Wang 2020-04-27  360   * @id:		the id associated with the IO
34a928cf49a7ef Jack Wang 2020-04-27  361   * @errno:	the error number of the IO.
34a928cf49a7ef Jack Wang 2020-04-27  362   *
34a928cf49a7ef Jack Wang 2020-04-27  363   * Return 0 on success, errno otherwise.
34a928cf49a7ef Jack Wang 2020-04-27  364   */
34a928cf49a7ef Jack Wang 2020-04-27  365  static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
34a928cf49a7ef Jack Wang 2020-04-27  366  			    int errno)
34a928cf49a7ef Jack Wang 2020-04-27  367  {
34a928cf49a7ef Jack Wang 2020-04-27  368  	struct rtrs_sess *s = con->c.sess;
34a928cf49a7ef Jack Wang 2020-04-27  369  	struct rtrs_srv_sess *sess = to_srv_sess(s);
34a928cf49a7ef Jack Wang 2020-04-27  370  	struct ib_send_wr inv_wr, imm_wr, *wr = NULL;
34a928cf49a7ef Jack Wang 2020-04-27  371  	struct ib_reg_wr rwr;
34a928cf49a7ef Jack Wang 2020-04-27  372  	struct rtrs_srv *srv = sess->srv;
34a928cf49a7ef Jack Wang 2020-04-27  373  	struct rtrs_srv_mr *srv_mr;
34a928cf49a7ef Jack Wang 2020-04-27  374  	bool need_inval = false;
34a928cf49a7ef Jack Wang 2020-04-27  375  	enum ib_send_flags flags;
34a928cf49a7ef Jack Wang 2020-04-27  376  	u32 imm;
34a928cf49a7ef Jack Wang 2020-04-27  377  	int err;
34a928cf49a7ef Jack Wang 2020-04-27  378  
34a928cf49a7ef Jack Wang 2020-04-27  379  	if (id->dir == READ) {
34a928cf49a7ef Jack Wang 2020-04-27  380  		struct rtrs_msg_rdma_read *rd_msg = id->rd_msg;
34a928cf49a7ef Jack Wang 2020-04-27  381  		size_t sg_cnt;
34a928cf49a7ef Jack Wang 2020-04-27  382  
34a928cf49a7ef Jack Wang 2020-04-27  383  		need_inval = le16_to_cpu(rd_msg->flags) &
34a928cf49a7ef Jack Wang 2020-04-27  384  				RTRS_MSG_NEED_INVAL_F;
34a928cf49a7ef Jack Wang 2020-04-27  385  		sg_cnt = le16_to_cpu(rd_msg->sg_cnt);
34a928cf49a7ef Jack Wang 2020-04-27  386  
34a928cf49a7ef Jack Wang 2020-04-27  387  		if (need_inval) {
34a928cf49a7ef Jack Wang 2020-04-27  388  			if (likely(sg_cnt)) {
34a928cf49a7ef Jack Wang 2020-04-27  389  				inv_wr.sg_list = NULL;
34a928cf49a7ef Jack Wang 2020-04-27  390  				inv_wr.num_sge = 0;
34a928cf49a7ef Jack Wang 2020-04-27  391  				inv_wr.opcode = IB_WR_SEND_WITH_INV;
34a928cf49a7ef Jack Wang 2020-04-27  392  				inv_wr.send_flags = 0;
34a928cf49a7ef Jack Wang 2020-04-27  393  				/* Only one key is actually used */
34a928cf49a7ef Jack Wang 2020-04-27  394  				inv_wr.ex.invalidate_rkey =
34a928cf49a7ef Jack Wang 2020-04-27  395  					le32_to_cpu(rd_msg->desc[0].key);
34a928cf49a7ef Jack Wang 2020-04-27  396  			} else {
34a928cf49a7ef Jack Wang 2020-04-27  397  				WARN_ON_ONCE(1);
34a928cf49a7ef Jack Wang 2020-04-27  398  				need_inval = false;
34a928cf49a7ef Jack Wang 2020-04-27  399  			}
34a928cf49a7ef Jack Wang 2020-04-27  400  		}
34a928cf49a7ef Jack Wang 2020-04-27  401  	}
34a928cf49a7ef Jack Wang 2020-04-27  402  
34a928cf49a7ef Jack Wang 2020-04-27  403  	if (need_inval && always_invalidate) {
34a928cf49a7ef Jack Wang 2020-04-27  404  		wr = &inv_wr;
34a928cf49a7ef Jack Wang 2020-04-27  405  		inv_wr.next = &rwr.wr;
34a928cf49a7ef Jack Wang 2020-04-27  406  		rwr.wr.next = &imm_wr;
34a928cf49a7ef Jack Wang 2020-04-27  407  	} else if (always_invalidate) {
34a928cf49a7ef Jack Wang 2020-04-27  408  		wr = &rwr.wr;
34a928cf49a7ef Jack Wang 2020-04-27  409  		rwr.wr.next = &imm_wr;
34a928cf49a7ef Jack Wang 2020-04-27  410  	} else if (need_inval) {
34a928cf49a7ef Jack Wang 2020-04-27  411  		wr = &inv_wr;
34a928cf49a7ef Jack Wang 2020-04-27  412  		inv_wr.next = &imm_wr;
34a928cf49a7ef Jack Wang 2020-04-27  413  	} else {
34a928cf49a7ef Jack Wang 2020-04-27  414  		wr = &imm_wr;
34a928cf49a7ef Jack Wang 2020-04-27  415  	}
34a928cf49a7ef Jack Wang 2020-04-27  416  	/*
34a928cf49a7ef Jack Wang 2020-04-27  417  	 * From time to time we have to post signalled sends,
34a928cf49a7ef Jack Wang 2020-04-27  418  	 * or send queue will fill up and only QP reset can help.
34a928cf49a7ef Jack Wang 2020-04-27  419  	 */
34a928cf49a7ef Jack Wang 2020-04-27  420  	flags = atomic_inc_return(&con->wr_cnt) % srv->queue_depth ?
34a928cf49a7ef Jack Wang 2020-04-27  421  		0 : IB_SEND_SIGNALED;
34a928cf49a7ef Jack Wang 2020-04-27  422  	imm = rtrs_to_io_rsp_imm(id->msg_id, errno, need_inval);
34a928cf49a7ef Jack Wang 2020-04-27  423  	imm_wr.next = NULL;
34a928cf49a7ef Jack Wang 2020-04-27  424  	if (always_invalidate) {
34a928cf49a7ef Jack Wang 2020-04-27  425  		struct ib_sge list;
34a928cf49a7ef Jack Wang 2020-04-27  426  		struct rtrs_msg_rkey_rsp *msg;
34a928cf49a7ef Jack Wang 2020-04-27  427  
34a928cf49a7ef Jack Wang 2020-04-27  428  		srv_mr = &sess->mrs[id->msg_id];
34a928cf49a7ef Jack Wang 2020-04-27  429  		rwr.wr.next = &imm_wr;
34a928cf49a7ef Jack Wang 2020-04-27  430  		rwr.wr.opcode = IB_WR_REG_MR;
34a928cf49a7ef Jack Wang 2020-04-27  431  		rwr.wr.num_sge = 0;
34a928cf49a7ef Jack Wang 2020-04-27  432  		rwr.wr.send_flags = 0;
34a928cf49a7ef Jack Wang 2020-04-27  433  		rwr.mr = srv_mr->mr;
34a928cf49a7ef Jack Wang 2020-04-27  434  		rwr.key = srv_mr->mr->rkey;
34a928cf49a7ef Jack Wang 2020-04-27  435  		rwr.access = (IB_ACCESS_LOCAL_WRITE |
34a928cf49a7ef Jack Wang 2020-04-27  436  			      IB_ACCESS_REMOTE_WRITE);
34a928cf49a7ef Jack Wang 2020-04-27  437  		msg = srv_mr->iu->buf;
34a928cf49a7ef Jack Wang 2020-04-27  438  		msg->buf_id = cpu_to_le16(id->msg_id);
34a928cf49a7ef Jack Wang 2020-04-27  439  		msg->type = cpu_to_le16(RTRS_MSG_RKEY_RSP);
34a928cf49a7ef Jack Wang 2020-04-27  440  		msg->rkey = cpu_to_le32(srv_mr->mr->rkey);
34a928cf49a7ef Jack Wang 2020-04-27  441  
34a928cf49a7ef Jack Wang 2020-04-27  442  		list.addr   = srv_mr->iu->dma_addr;
34a928cf49a7ef Jack Wang 2020-04-27  443  		list.length = sizeof(*msg);
34a928cf49a7ef Jack Wang 2020-04-27  444  		list.lkey   = sess->s.dev->ib_pd->local_dma_lkey;
34a928cf49a7ef Jack Wang 2020-04-27  445  		imm_wr.sg_list = &list;
34a928cf49a7ef Jack Wang 2020-04-27  446  		imm_wr.num_sge = 1;
34a928cf49a7ef Jack Wang 2020-04-27  447  		imm_wr.opcode = IB_WR_SEND_WITH_IMM;
34a928cf49a7ef Jack Wang 2020-04-27  448  		ib_dma_sync_single_for_device(sess->s.dev->ib_dev,
34a928cf49a7ef Jack Wang 2020-04-27  449  					      srv_mr->iu->dma_addr,
34a928cf49a7ef Jack Wang 2020-04-27  450  					      srv_mr->iu->size, DMA_TO_DEVICE);
34a928cf49a7ef Jack Wang 2020-04-27  451  	} else {
34a928cf49a7ef Jack Wang 2020-04-27  452  		imm_wr.sg_list = NULL;
34a928cf49a7ef Jack Wang 2020-04-27  453  		imm_wr.num_sge = 0;
34a928cf49a7ef Jack Wang 2020-04-27  454  		imm_wr.opcode = IB_WR_RDMA_WRITE_WITH_IMM;
34a928cf49a7ef Jack Wang 2020-04-27  455  	}
34a928cf49a7ef Jack Wang 2020-04-27  456  	imm_wr.send_flags = flags;
34a928cf49a7ef Jack Wang 2020-04-27  457  	imm_wr.wr_cqe   = &io_comp_cqe;
34a928cf49a7ef Jack Wang 2020-04-27  458  
34a928cf49a7ef Jack Wang 2020-04-27  459  	imm_wr.ex.imm_data = cpu_to_be32(imm);
34a928cf49a7ef Jack Wang 2020-04-27  460  
34a928cf49a7ef Jack Wang 2020-04-27  461  	err = ib_post_send(id->con->c.qp, wr, NULL);
34a928cf49a7ef Jack Wang 2020-04-27  462  	if (unlikely(err))
34a928cf49a7ef Jack Wang 2020-04-27  463  		rtrs_err_rl(s, "Posting RDMA-Reply to QP failed, err: %d\n",
34a928cf49a7ef Jack Wang 2020-04-27  464  			     err);
34a928cf49a7ef Jack Wang 2020-04-27  465  
34a928cf49a7ef Jack Wang 2020-04-27  466  	return err;
34a928cf49a7ef Jack Wang 2020-04-27  467  }
34a928cf49a7ef Jack Wang 2020-04-27  468  
34a928cf49a7ef Jack Wang 2020-04-27  469  void close_sess(struct rtrs_srv_sess *sess)
34a928cf49a7ef Jack Wang 2020-04-27  470  {
34a928cf49a7ef Jack Wang 2020-04-27  471  	enum rtrs_srv_state old_state;
34a928cf49a7ef Jack Wang 2020-04-27  472  
34a928cf49a7ef Jack Wang 2020-04-27  473  	if (rtrs_srv_change_state_get_old(sess, RTRS_SRV_CLOSING,
34a928cf49a7ef Jack Wang 2020-04-27  474  					   &old_state))
34a928cf49a7ef Jack Wang 2020-04-27  475  		queue_work(rtrs_wq, &sess->close_work);
34a928cf49a7ef Jack Wang 2020-04-27  476  	WARN_ON(sess->state != RTRS_SRV_CLOSING);
34a928cf49a7ef Jack Wang 2020-04-27  477  }
34a928cf49a7ef Jack Wang 2020-04-27  478  
34a928cf49a7ef Jack Wang 2020-04-27  479  static inline const char *rtrs_srv_state_str(enum rtrs_srv_state state)
34a928cf49a7ef Jack Wang 2020-04-27  480  {
34a928cf49a7ef Jack Wang 2020-04-27  481  	switch (state) {
34a928cf49a7ef Jack Wang 2020-04-27  482  	case RTRS_SRV_CONNECTING:
34a928cf49a7ef Jack Wang 2020-04-27  483  		return "RTRS_SRV_CONNECTING";
34a928cf49a7ef Jack Wang 2020-04-27  484  	case RTRS_SRV_CONNECTED:
34a928cf49a7ef Jack Wang 2020-04-27  485  		return "RTRS_SRV_CONNECTED";
34a928cf49a7ef Jack Wang 2020-04-27  486  	case RTRS_SRV_CLOSING:
34a928cf49a7ef Jack Wang 2020-04-27  487  		return "RTRS_SRV_CLOSING";
34a928cf49a7ef Jack Wang 2020-04-27  488  	case RTRS_SRV_CLOSED:
34a928cf49a7ef Jack Wang 2020-04-27  489  		return "RTRS_SRV_CLOSED";
34a928cf49a7ef Jack Wang 2020-04-27  490  	default:
34a928cf49a7ef Jack Wang 2020-04-27  491  		return "UNKNOWN";
34a928cf49a7ef Jack Wang 2020-04-27  492  	}
34a928cf49a7ef Jack Wang 2020-04-27  493  }
34a928cf49a7ef Jack Wang 2020-04-27  494  
34a928cf49a7ef Jack Wang 2020-04-27  495  /**
34a928cf49a7ef Jack Wang 2020-04-27  496   * rtrs_srv_resp_rdma() - Finish an RDMA request
34a928cf49a7ef Jack Wang 2020-04-27  497   *
34a928cf49a7ef Jack Wang 2020-04-27  498   * @id:		Internal RTRS operation identifier
34a928cf49a7ef Jack Wang 2020-04-27  499   * @status:	Response Code sent to the other side for this operation.
34a928cf49a7ef Jack Wang 2020-04-27  500   *		0 = success, <=0 error
34a928cf49a7ef Jack Wang 2020-04-27  501   * Context: any
34a928cf49a7ef Jack Wang 2020-04-27  502   *
34a928cf49a7ef Jack Wang 2020-04-27  503   * Finish a RDMA operation. A message is sent to the client and the
34a928cf49a7ef Jack Wang 2020-04-27  504   * corresponding memory areas will be released.
34a928cf49a7ef Jack Wang 2020-04-27  505   */
34a928cf49a7ef Jack Wang 2020-04-27  506  bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int status)
34a928cf49a7ef Jack Wang 2020-04-27  507  {
34a928cf49a7ef Jack Wang 2020-04-27 @508  	struct rtrs_srv_con *con = id->con;
34a928cf49a7ef Jack Wang 2020-04-27  509  	struct rtrs_sess *s = con->c.sess;
34a928cf49a7ef Jack Wang 2020-04-27  510  	struct rtrs_srv_sess *sess = to_srv_sess(s);
34a928cf49a7ef Jack Wang 2020-04-27  511  	int err;
34a928cf49a7ef Jack Wang 2020-04-27  512  
34a928cf49a7ef Jack Wang 2020-04-27  513  	if (WARN_ON(!id))
34a928cf49a7ef Jack Wang 2020-04-27  514  		return true;
34a928cf49a7ef Jack Wang 2020-04-27  515  
34a928cf49a7ef Jack Wang 2020-04-27  516  	id->status = status;
34a928cf49a7ef Jack Wang 2020-04-27  517  
34a928cf49a7ef Jack Wang 2020-04-27  518  	if (unlikely(sess->state != RTRS_SRV_CONNECTED)) {
34a928cf49a7ef Jack Wang 2020-04-27  519  		rtrs_err_rl(s,
34a928cf49a7ef Jack Wang 2020-04-27  520  			     "Sending I/O response failed,  session is disconnected, sess state %s\n",
34a928cf49a7ef Jack Wang 2020-04-27  521  			     rtrs_srv_state_str(sess->state));
34a928cf49a7ef Jack Wang 2020-04-27  522  		goto out;
34a928cf49a7ef Jack Wang 2020-04-27  523  	}
34a928cf49a7ef Jack Wang 2020-04-27  524  	if (always_invalidate) {
34a928cf49a7ef Jack Wang 2020-04-27  525  		struct rtrs_srv_mr *mr = &sess->mrs[id->msg_id];
34a928cf49a7ef Jack Wang 2020-04-27  526  
34a928cf49a7ef Jack Wang 2020-04-27  527  		ib_update_fast_reg_key(mr->mr, ib_inc_rkey(mr->mr->rkey));
34a928cf49a7ef Jack Wang 2020-04-27  528  	}
34a928cf49a7ef Jack Wang 2020-04-27  529  	if (unlikely(atomic_sub_return(1,
34a928cf49a7ef Jack Wang 2020-04-27  530  				       &con->sq_wr_avail) < 0)) {
34a928cf49a7ef Jack Wang 2020-04-27  531  		pr_err("IB send queue full\n");
34a928cf49a7ef Jack Wang 2020-04-27  532  		atomic_add(1, &con->sq_wr_avail);
34a928cf49a7ef Jack Wang 2020-04-27  533  		spin_lock(&con->rsp_wr_wait_lock);
34a928cf49a7ef Jack Wang 2020-04-27  534  		list_add_tail(&id->wait_list, &con->rsp_wr_wait_list);
34a928cf49a7ef Jack Wang 2020-04-27  535  		spin_unlock(&con->rsp_wr_wait_lock);
34a928cf49a7ef Jack Wang 2020-04-27  536  		return false;
34a928cf49a7ef Jack Wang 2020-04-27  537  	}
34a928cf49a7ef Jack Wang 2020-04-27  538  
34a928cf49a7ef Jack Wang 2020-04-27  539  	if (status || id->dir == WRITE || !id->rd_msg->sg_cnt)
34a928cf49a7ef Jack Wang 2020-04-27  540  		err = send_io_resp_imm(con, id, status);
34a928cf49a7ef Jack Wang 2020-04-27  541  	else
34a928cf49a7ef Jack Wang 2020-04-27  542  		err = rdma_write_sg(id);
34a928cf49a7ef Jack Wang 2020-04-27  543  
34a928cf49a7ef Jack Wang 2020-04-27  544  	if (unlikely(err)) {
34a928cf49a7ef Jack Wang 2020-04-27  545  		rtrs_err_rl(s, "IO response failed: %d\n", err);
34a928cf49a7ef Jack Wang 2020-04-27  546  		close_sess(sess);
34a928cf49a7ef Jack Wang 2020-04-27  547  	}
34a928cf49a7ef Jack Wang 2020-04-27  548  out:
34a928cf49a7ef Jack Wang 2020-04-27  549  	rtrs_srv_put_ops_ids(sess);
34a928cf49a7ef Jack Wang 2020-04-27  550  	return true;
34a928cf49a7ef Jack Wang 2020-04-27  551  }
34a928cf49a7ef Jack Wang 2020-04-27  552  EXPORT_SYMBOL(rtrs_srv_resp_rdma);
34a928cf49a7ef Jack Wang 2020-04-27  553  
34a928cf49a7ef Jack Wang 2020-04-27  554  /**
34a928cf49a7ef Jack Wang 2020-04-27  555   * rtrs_srv_set_sess_priv() - Set private pointer in rtrs_srv.
34a928cf49a7ef Jack Wang 2020-04-27  556   * @srv:	Session pointer
34a928cf49a7ef Jack Wang 2020-04-27  557   * @priv:	The private pointer that is associated with the session.
34a928cf49a7ef Jack Wang 2020-04-27  558   */
34a928cf49a7ef Jack Wang 2020-04-27  559  void rtrs_srv_set_sess_priv(struct rtrs_srv *srv, void *priv)
34a928cf49a7ef Jack Wang 2020-04-27  560  {
34a928cf49a7ef Jack Wang 2020-04-27  561  	srv->priv = priv;
34a928cf49a7ef Jack Wang 2020-04-27  562  }
34a928cf49a7ef Jack Wang 2020-04-27  563  EXPORT_SYMBOL(rtrs_srv_set_sess_priv);
34a928cf49a7ef Jack Wang 2020-04-27  564  
34a928cf49a7ef Jack Wang 2020-04-27  565  static void unmap_cont_bufs(struct rtrs_srv_sess *sess)
34a928cf49a7ef Jack Wang 2020-04-27  566  {
34a928cf49a7ef Jack Wang 2020-04-27  567  	int i;
34a928cf49a7ef Jack Wang 2020-04-27  568  
34a928cf49a7ef Jack Wang 2020-04-27  569  	for (i = 0; i < sess->mrs_num; i++) {
34a928cf49a7ef Jack Wang 2020-04-27  570  		struct rtrs_srv_mr *srv_mr;
34a928cf49a7ef Jack Wang 2020-04-27  571  
34a928cf49a7ef Jack Wang 2020-04-27  572  		srv_mr = &sess->mrs[i];
34a928cf49a7ef Jack Wang 2020-04-27  573  		rtrs_iu_free(srv_mr->iu, DMA_TO_DEVICE,
34a928cf49a7ef Jack Wang 2020-04-27  574  			      sess->s.dev->ib_dev, 1);
34a928cf49a7ef Jack Wang 2020-04-27  575  		ib_dereg_mr(srv_mr->mr);
34a928cf49a7ef Jack Wang 2020-04-27  576  		ib_dma_unmap_sg(sess->s.dev->ib_dev, srv_mr->sgt.sgl,
34a928cf49a7ef Jack Wang 2020-04-27  577  				srv_mr->sgt.nents, DMA_BIDIRECTIONAL);
34a928cf49a7ef Jack Wang 2020-04-27  578  		sg_free_table(&srv_mr->sgt);
34a928cf49a7ef Jack Wang 2020-04-27  579  	}
34a928cf49a7ef Jack Wang 2020-04-27  580  	kfree(sess->mrs);
34a928cf49a7ef Jack Wang 2020-04-27  581  }
34a928cf49a7ef Jack Wang 2020-04-27  582  
34a928cf49a7ef Jack Wang 2020-04-27  583  static int map_cont_bufs(struct rtrs_srv_sess *sess)
34a928cf49a7ef Jack Wang 2020-04-27  584  {
34a928cf49a7ef Jack Wang 2020-04-27  585  	struct rtrs_srv *srv = sess->srv;
34a928cf49a7ef Jack Wang 2020-04-27  586  	struct rtrs_sess *ss = &sess->s;
34a928cf49a7ef Jack Wang 2020-04-27  587  	int i, mri, err, mrs_num;
34a928cf49a7ef Jack Wang 2020-04-27  588  	unsigned int chunk_bits;
34a928cf49a7ef Jack Wang 2020-04-27  589  	int chunks_per_mr = 1;
34a928cf49a7ef Jack Wang 2020-04-27  590  
34a928cf49a7ef Jack Wang 2020-04-27  591  	/*
34a928cf49a7ef Jack Wang 2020-04-27  592  	 * Here we map queue_depth chunks to MR.  Firstly we have to
34a928cf49a7ef Jack Wang 2020-04-27  593  	 * figure out how many chunks can we map per MR.
34a928cf49a7ef Jack Wang 2020-04-27  594  	 */
34a928cf49a7ef Jack Wang 2020-04-27  595  	if (always_invalidate) {
34a928cf49a7ef Jack Wang 2020-04-27  596  		/*
34a928cf49a7ef Jack Wang 2020-04-27  597  		 * in order to do invalidate for each chunks of memory, we needs
34a928cf49a7ef Jack Wang 2020-04-27  598  		 * more memory regions.
34a928cf49a7ef Jack Wang 2020-04-27  599  		 */
34a928cf49a7ef Jack Wang 2020-04-27  600  		mrs_num = srv->queue_depth;
34a928cf49a7ef Jack Wang 2020-04-27  601  	} else {
34a928cf49a7ef Jack Wang 2020-04-27  602  		chunks_per_mr =
34a928cf49a7ef Jack Wang 2020-04-27  603  			sess->s.dev->ib_dev->attrs.max_fast_reg_page_list_len;
34a928cf49a7ef Jack Wang 2020-04-27  604  		mrs_num = DIV_ROUND_UP(srv->queue_depth, chunks_per_mr);
34a928cf49a7ef Jack Wang 2020-04-27  605  		chunks_per_mr = DIV_ROUND_UP(srv->queue_depth, mrs_num);
34a928cf49a7ef Jack Wang 2020-04-27  606  	}
34a928cf49a7ef Jack Wang 2020-04-27  607  
34a928cf49a7ef Jack Wang 2020-04-27  608  	sess->mrs = kcalloc(mrs_num, sizeof(*sess->mrs), GFP_KERNEL);
34a928cf49a7ef Jack Wang 2020-04-27  609  	if (!sess->mrs)
34a928cf49a7ef Jack Wang 2020-04-27  610  		return -ENOMEM;
34a928cf49a7ef Jack Wang 2020-04-27  611  
34a928cf49a7ef Jack Wang 2020-04-27  612  	sess->mrs_num = mrs_num;
34a928cf49a7ef Jack Wang 2020-04-27  613  
34a928cf49a7ef Jack Wang 2020-04-27  614  	for (mri = 0; mri < mrs_num; mri++) {
34a928cf49a7ef Jack Wang 2020-04-27  615  		struct rtrs_srv_mr *srv_mr = &sess->mrs[mri];
34a928cf49a7ef Jack Wang 2020-04-27  616  		struct sg_table *sgt = &srv_mr->sgt;
34a928cf49a7ef Jack Wang 2020-04-27  617  		struct scatterlist *s;
34a928cf49a7ef Jack Wang 2020-04-27  618  		struct ib_mr *mr;
34a928cf49a7ef Jack Wang 2020-04-27  619  		int nr, chunks;
34a928cf49a7ef Jack Wang 2020-04-27 @620  		struct rtrs_msg_rkey_rsp *rsp;
34a928cf49a7ef Jack Wang 2020-04-27  621  
34a928cf49a7ef Jack Wang 2020-04-27  622  		chunks = chunks_per_mr * mri;
34a928cf49a7ef Jack Wang 2020-04-27  623  		if (!always_invalidate)
34a928cf49a7ef Jack Wang 2020-04-27  624  			chunks_per_mr = min_t(int, chunks_per_mr,
34a928cf49a7ef Jack Wang 2020-04-27  625  					      srv->queue_depth - chunks);
34a928cf49a7ef Jack Wang 2020-04-27  626  
34a928cf49a7ef Jack Wang 2020-04-27  627  		err = sg_alloc_table(sgt, chunks_per_mr, GFP_KERNEL);
34a928cf49a7ef Jack Wang 2020-04-27  628  		if (err)
34a928cf49a7ef Jack Wang 2020-04-27  629  			goto err;
34a928cf49a7ef Jack Wang 2020-04-27  630  
34a928cf49a7ef Jack Wang 2020-04-27  631  		for_each_sg(sgt->sgl, s, chunks_per_mr, i)
34a928cf49a7ef Jack Wang 2020-04-27  632  			sg_set_page(s, srv->chunks[chunks + i],
34a928cf49a7ef Jack Wang 2020-04-27  633  				    max_chunk_size, 0);
34a928cf49a7ef Jack Wang 2020-04-27  634  
34a928cf49a7ef Jack Wang 2020-04-27  635  		nr = ib_dma_map_sg(sess->s.dev->ib_dev, sgt->sgl,
34a928cf49a7ef Jack Wang 2020-04-27  636  				   sgt->nents, DMA_BIDIRECTIONAL);
34a928cf49a7ef Jack Wang 2020-04-27  637  		if (nr < sgt->nents) {
34a928cf49a7ef Jack Wang 2020-04-27  638  			err = nr < 0 ? nr : -EINVAL;
34a928cf49a7ef Jack Wang 2020-04-27  639  			goto free_sg;
34a928cf49a7ef Jack Wang 2020-04-27  640  		}
34a928cf49a7ef Jack Wang 2020-04-27  641  		mr = ib_alloc_mr(sess->s.dev->ib_pd, IB_MR_TYPE_MEM_REG,
34a928cf49a7ef Jack Wang 2020-04-27  642  				 sgt->nents);
34a928cf49a7ef Jack Wang 2020-04-27  643  		if (IS_ERR(mr)) {
34a928cf49a7ef Jack Wang 2020-04-27  644  			err = PTR_ERR(mr);
34a928cf49a7ef Jack Wang 2020-04-27  645  			goto unmap_sg;
34a928cf49a7ef Jack Wang 2020-04-27  646  		}
34a928cf49a7ef Jack Wang 2020-04-27  647  		nr = ib_map_mr_sg(mr, sgt->sgl, sgt->nents,
34a928cf49a7ef Jack Wang 2020-04-27  648  				  NULL, max_chunk_size);
34a928cf49a7ef Jack Wang 2020-04-27  649  		if (nr < sgt->nents) {
34a928cf49a7ef Jack Wang 2020-04-27  650  			err = nr < 0 ? nr : -EINVAL;
34a928cf49a7ef Jack Wang 2020-04-27  651  			goto dereg_mr;
34a928cf49a7ef Jack Wang 2020-04-27  652  		}
34a928cf49a7ef Jack Wang 2020-04-27  653  
34a928cf49a7ef Jack Wang 2020-04-27  654  		if (always_invalidate) {
34a928cf49a7ef Jack Wang 2020-04-27  655  			srv_mr->iu = rtrs_iu_alloc(1, sizeof(*rsp), GFP_KERNEL,
34a928cf49a7ef Jack Wang 2020-04-27  656  						    sess->s.dev->ib_dev,
34a928cf49a7ef Jack Wang 2020-04-27  657  						    DMA_TO_DEVICE,
34a928cf49a7ef Jack Wang 2020-04-27  658  						    rtrs_srv_rdma_done);
34a928cf49a7ef Jack Wang 2020-04-27  659  			if (!srv_mr->iu) {
34a928cf49a7ef Jack Wang 2020-04-27  660  				rtrs_err(ss, "rtrs_iu_alloc(), err: %d\n",
34a928cf49a7ef Jack Wang 2020-04-27  661  					  -ENOMEM);
34a928cf49a7ef Jack Wang 2020-04-27  662  				goto free_iu;
34a928cf49a7ef Jack Wang 2020-04-27  663  			}
34a928cf49a7ef Jack Wang 2020-04-27  664  		}
34a928cf49a7ef Jack Wang 2020-04-27  665  		/* Eventually dma addr for each chunk can be cached */
34a928cf49a7ef Jack Wang 2020-04-27  666  		for_each_sg(sgt->sgl, s, sgt->orig_nents, i)
34a928cf49a7ef Jack Wang 2020-04-27  667  			sess->dma_addr[chunks + i] = sg_dma_address(s);
34a928cf49a7ef Jack Wang 2020-04-27  668  
34a928cf49a7ef Jack Wang 2020-04-27  669  		ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
34a928cf49a7ef Jack Wang 2020-04-27  670  		srv_mr->mr = mr;
34a928cf49a7ef Jack Wang 2020-04-27  671  
34a928cf49a7ef Jack Wang 2020-04-27  672  		continue;
34a928cf49a7ef Jack Wang 2020-04-27  673  err:
34a928cf49a7ef Jack Wang 2020-04-27  674  		while (mri--) {
34a928cf49a7ef Jack Wang 2020-04-27  675  			srv_mr = &sess->mrs[mri];
34a928cf49a7ef Jack Wang 2020-04-27  676  			sgt = &srv_mr->sgt;
34a928cf49a7ef Jack Wang 2020-04-27  677  			mr = srv_mr->mr;
34a928cf49a7ef Jack Wang 2020-04-27  678  free_iu:
34a928cf49a7ef Jack Wang 2020-04-27  679  			rtrs_iu_free(srv_mr->iu, DMA_TO_DEVICE,
34a928cf49a7ef Jack Wang 2020-04-27  680  				      sess->s.dev->ib_dev, 1);
34a928cf49a7ef Jack Wang 2020-04-27  681  dereg_mr:
34a928cf49a7ef Jack Wang 2020-04-27  682  			ib_dereg_mr(mr);
34a928cf49a7ef Jack Wang 2020-04-27  683  unmap_sg:
34a928cf49a7ef Jack Wang 2020-04-27  684  			ib_dma_unmap_sg(sess->s.dev->ib_dev, sgt->sgl,
34a928cf49a7ef Jack Wang 2020-04-27  685  					sgt->nents, DMA_BIDIRECTIONAL);
34a928cf49a7ef Jack Wang 2020-04-27  686  free_sg:
34a928cf49a7ef Jack Wang 2020-04-27  687  			sg_free_table(sgt);
34a928cf49a7ef Jack Wang 2020-04-27  688  		}
34a928cf49a7ef Jack Wang 2020-04-27  689  		kfree(sess->mrs);
34a928cf49a7ef Jack Wang 2020-04-27  690  
34a928cf49a7ef Jack Wang 2020-04-27  691  		return err;
34a928cf49a7ef Jack Wang 2020-04-27  692  	}
34a928cf49a7ef Jack Wang 2020-04-27  693  
34a928cf49a7ef Jack Wang 2020-04-27  694  	chunk_bits = ilog2(srv->queue_depth - 1) + 1;
34a928cf49a7ef Jack Wang 2020-04-27  695  	sess->mem_bits = (MAX_IMM_PAYL_BITS - chunk_bits);
34a928cf49a7ef Jack Wang 2020-04-27  696  
34a928cf49a7ef Jack Wang 2020-04-27  697  	return 0;
34a928cf49a7ef Jack Wang 2020-04-27  698  }
34a928cf49a7ef Jack Wang 2020-04-27  699  

:::::: The code at line 508 was first introduced by commit
:::::: 34a928cf49a7ef7ae5027dfa9c2570ef9c5dd97e RDMA/rtrs: server: main functionality

:::::: TO: Jack Wang <jinpu.wang@cloud.ionos.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
